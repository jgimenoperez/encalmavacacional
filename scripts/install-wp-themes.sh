#!/bin/bash

# Script para instalar temas de terceros desde wp-themes-required.txt

set -e

CONTAINER_WP="encalma_wordpress"
THEMES_FILE="./wp-themes-required.txt"

if [ ! -f "$THEMES_FILE" ]; then
  echo "❌ Archivo no encontrado: $THEMES_FILE"
  exit 1
fi

echo "🎨 Instalando temas requeridos..."
echo ""

# Contar temas
TOTAL=$(grep -v "^#" "$THEMES_FILE" | grep -v "^$" | wc -l)
CURRENT=0

while IFS= read -r theme; do
  # Saltar comentarios y líneas vacías
  [[ "$theme" =~ ^#.*$ ]] && continue
  [[ -z "$theme" ]] && continue

  CURRENT=$((CURRENT + 1))
  echo "[$CURRENT/$TOTAL] Instalando: $theme"
  docker exec "$CONTAINER_WP" wp theme install "$theme" --quiet || echo "⚠️  Error instalando $theme"
done < "$THEMES_FILE"

echo ""
echo "✅ Instalación completada"
echo ""
echo "📝 Para activar un tema:"
echo "   docker exec encalma_wordpress wp theme activate nombre-tema"
