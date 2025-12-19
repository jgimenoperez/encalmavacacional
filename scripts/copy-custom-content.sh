#!/bin/bash

# Script para copiar plugins/temas custom desde Docker a la máquina anfitriona

set -e

CONTAINER_WP="encalma_wordpress"
WP_CONTENT_CUSTOM="./wp-content-custom"

echo "📁 Copiando contenido custom desde Docker..."
echo ""

# 1. Copiar plugins custom
echo "🔌 Copiando plugins custom..."
if [ -d "$WP_CONTENT_CUSTOM/plugins" ]; then
  docker cp "$CONTAINER_WP:/var/www/html/wp-content/plugins/." "$WP_CONTENT_CUSTOM/plugins-temp/" 2>/dev/null || mkdir -p "$WP_CONTENT_CUSTOM/plugins-temp"

  echo "   Plugins encontrados:"
  ls -1 "$WP_CONTENT_CUSTOM/plugins-temp" 2>/dev/null || echo "   (ninguno)"
  echo ""
  echo "   ⚠️  Revisa y elimina plugins de terceros antes de versionar"
  echo "   Mantén solo tus plugins custom"
fi

# 2. Copiar temas custom
echo "🎨 Copiando temas custom..."
if [ -d "$WP_CONTENT_CUSTOM/themes" ]; then
  docker cp "$CONTAINER_WP:/var/www/html/wp-content/themes/." "$WP_CONTENT_CUSTOM/themes-temp/" 2>/dev/null || mkdir -p "$WP_CONTENT_CUSTOM/themes-temp"

  echo "   Temas encontrados:"
  ls -1 "$WP_CONTENT_CUSTOM/themes-temp" 2>/dev/null || echo "   (ninguno)"
  echo ""
  echo "   ⚠️  Revisa y elimina temas de terceros antes de versionar"
  echo "   Mantén solo tus temas custom"
fi

# 3. Listar imágenes importantes
echo ""
echo "🖼️  Imágenes en uploads (muestra primeras 10):"
docker exec "$CONTAINER_WP" find /var/www/html/wp-content/uploads -maxdepth 3 -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.svg" -o -name "*.gif" \) 2>/dev/null | head -10 || echo "   (ninguna)"

echo ""
echo "✅ Copia completada"
echo ""
echo "📝 Próximos pasos:"
echo "   1. Revisa wp-content-custom/plugins-temp/ - Copia solo tus custom a plugins/"
echo "   2. Revisa wp-content-custom/themes-temp/ - Copia solo tus custom a themes/"
echo "   3. Copia imágenes importantes a uploads-referencia/"
echo "   4. Elimina directorios -temp"
echo "   5. git add wp-content-custom/"
echo "   6. git commit -m 'feat: agregar contenido custom'"
