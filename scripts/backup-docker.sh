#!/bin/bash

# Script de Backup para WordPress + Docker
# Crea backup de la BD y exporta XML de WordPress

set -e

BACKUP_DIR="./backups/$(date +%Y-%m-%d_%H-%M-%S)"
CONTAINER_DB="encalma_db"
CONTAINER_WP="encalma_wordpress"
DB_USER="wordpress_user"
DB_PASSWORD="wordpress_password"
DB_NAME="wordpress_db"

echo "📦 Iniciando backup de WordPress..."
mkdir -p "$BACKUP_DIR"

# 1. Backup de la base de datos
echo "🔄 Exportando base de datos..."
docker exec "$CONTAINER_DB" mysqldump -u "$DB_USER" -p"$DB_PASSWORD" \
  --single-transaction --no-tablespaces "$DB_NAME" \
  > "$BACKUP_DIR/database.sql"

# 2. Exportar contenido como XML de WordPress
echo "📄 Exportando contenido de WordPress (XML)..."
docker exec "$CONTAINER_WP" wp export \
  --dir=/tmp \
  --filename=export.xml \
  > /dev/null 2>&1 || echo "⚠️  WP-CLI no disponible, saltando export XML"

if [ -f /tmp/export.xml ]; then
  docker cp "$CONTAINER_WP:/tmp/export.xml" "$BACKUP_DIR/export.xml"
  docker exec "$CONTAINER_WP" rm /tmp/export.xml
fi

# 3. Listar backup creado
echo ""
echo "✅ Backup completado en: $BACKUP_DIR"
ls -lh "$BACKUP_DIR"

echo ""
echo "📝 Para restaurar:"
echo "   docker exec -i encalma_db mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME < $BACKUP_DIR/database.sql"
