#!/bin/bash

# Script para exportar solo la estructura de la BD (sin datos)
# Útil para versionar en Git como referencia

set -e

CONTAINER_DB="encalma_db"
DB_USER="wordpress_user"
DB_PASSWORD="wordpress_password"
DB_NAME="wordpress_db"
OUTPUT_FILE="./sql-exports/estructura-db-$(date +%Y-%m-%d).sql"

echo "📊 Exportando estructura de BD..."
mkdir -p ./sql-exports

docker exec "$CONTAINER_DB" mysqldump \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  --no-data \
  --single-transaction \
  --no-tablespaces \
  "$DB_NAME" > "$OUTPUT_FILE"

echo "✅ Estructura exportada a: $OUTPUT_FILE"
echo ""
echo "📝 Para commitar en Git:"
echo "   git add $OUTPUT_FILE"
echo "   git commit -m 'docs: actualizar estructura de BD'"
echo "   git push origin main"
