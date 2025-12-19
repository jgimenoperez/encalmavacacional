#!/bin/bash

# Script para restaurar backup de WordPress + Docker

set -e

if [ -z "$1" ]; then
  echo "❌ Uso: $0 <path-to-backup-dir>"
  echo ""
  echo "Ejemplo: $0 ./backups/2025-12-19_10-30-45"
  exit 1
fi

BACKUP_DIR="$1"
CONTAINER_DB="encalma_db"
CONTAINER_WP="encalma_wordpress"
DB_USER="wordpress_user"
DB_PASSWORD="wordpress_password"
DB_NAME="wordpress_db"

if [ ! -d "$BACKUP_DIR" ]; then
  echo "❌ Directorio de backup no encontrado: $BACKUP_DIR"
  exit 1
fi

echo "🔄 Iniciando restauración desde: $BACKUP_DIR"
echo ""

# 1. Restaurar base de datos
if [ -f "$BACKUP_DIR/database.sql" ]; then
  echo "📊 Restaurando base de datos..."
  docker exec -i "$CONTAINER_DB" mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" \
    < "$BACKUP_DIR/database.sql"
  echo "✅ Base de datos restaurada"
else
  echo "❌ No se encontró database.sql"
  exit 1
fi

# 2. Importar XML si existe
if [ -f "$BACKUP_DIR/export.xml" ]; then
  echo "📄 Importando contenido desde XML..."
  docker cp "$BACKUP_DIR/export.xml" "$CONTAINER_WP:/tmp/import.xml"

  docker exec "$CONTAINER_WP" wp import /tmp/import.xml --authors=create \
    > /dev/null 2>&1 || echo "⚠️  No se pudo importar XML automáticamente"

  docker exec "$CONTAINER_WP" rm /tmp/import.xml
  echo "✅ Contenido importado"
fi

echo ""
echo "✅ Restauración completada"
echo ""
echo "📝 Próximos pasos:"
echo "   1. Verifica http://localhost:8080"
echo "   2. Ingresa a WordPress con tus credenciales"
echo "   3. Verifica que todo esté correcto"
