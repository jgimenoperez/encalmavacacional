#!/bin/bash

# Script para instalar plugins de terceros desde wp-plugins-required.txt

set -e

CONTAINER_WP="encalma_wordpress"
PLUGINS_FILE="./wp-plugins-required.txt"

if [ ! -f "$PLUGINS_FILE" ]; then
  echo "❌ Archivo no encontrado: $PLUGINS_FILE"
  exit 1
fi

echo "📦 Instalando plugins requeridos..."
echo ""

# Contar plugins
TOTAL=$(grep -v "^#" "$PLUGINS_FILE" | grep -v "^$" | wc -l)
CURRENT=0

while IFS= read -r plugin; do
  # Saltar comentarios y líneas vacías
  [[ "$plugin" =~ ^#.*$ ]] && continue
  [[ -z "$plugin" ]] && continue

  CURRENT=$((CURRENT + 1))
  echo "[$CURRENT/$TOTAL] Instalando: $plugin"
  docker exec "$CONTAINER_WP" wp plugin install "$plugin" --quiet || echo "⚠️  Error instalando $plugin"
done < "$PLUGINS_FILE"

echo ""
echo "✅ Instalación completada"
echo ""
echo "📝 Para activar plugins:"
echo "   docker exec encalma_wordpress wp plugin activate --all"
