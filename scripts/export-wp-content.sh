#!/bin/bash

# Script para exportar contenido personalizado de WordPress
# Plugins custom, temas custom e imágenes de referencia

set -e

CONTAINER_WP="encalma_wordpress"
EXPORT_DIR="./wp-content-custom"

echo "📦 Exportando contenido personalizado de WordPress..."
mkdir -p "$EXPORT_DIR"/{plugins,themes,uploads-referencia}

# 1. Exportar plugins custom
echo "🔌 Exportando plugins custom..."
docker cp "$CONTAINER_WP:/var/www/html/wp-content/plugins" "$EXPORT_DIR/plugins-temp"

# Filtrar solo plugins custom (no core, no Hello Dolly, etc.)
if [ -d "$EXPORT_DIR/plugins-temp" ]; then
  # Aquí puedes agregar lógica para identificar cuáles son custom
  # Por ahora, lista lo que encuentra
  echo "   Plugins encontrados:"
  ls -1 "$EXPORT_DIR/plugins-temp" | grep -v "hello" || true

  # Copiar todos (después filtrarás manualmente)
  cp -r "$EXPORT_DIR/plugins-temp"/* "$EXPORT_DIR/plugins/" 2>/dev/null || true
  rm -rf "$EXPORT_DIR/plugins-temp"
fi

# 2. Exportar temas custom
echo "🎨 Exportando temas custom..."
docker cp "$CONTAINER_WP:/var/www/html/wp-content/themes" "$EXPORT_DIR/themes-temp"

if [ -d "$EXPORT_DIR/themes-temp" ]; then
  # Filtrar solo temas custom (no twentytwentyfour, etc.)
  echo "   Temas encontrados:"
  ls -1 "$EXPORT_DIR/themes-temp" | grep -v "twentytwenty" || true

  cp -r "$EXPORT_DIR/themes-temp"/* "$EXPORT_DIR/themes/" 2>/dev/null || true
  rm -rf "$EXPORT_DIR/themes-temp"
fi

# 3. Listar imágenes importantes
echo "🖼️  Imágenes principales encontradas:"
docker exec "$CONTAINER_WP" find /var/www/html/wp-content/uploads -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.svg" \) -exec basename {} \; | head -20

echo ""
echo "✅ Exportación completada"
echo ""
echo "📝 Próximos pasos:"
echo "   1. Revisa $EXPORT_DIR/plugins/ - Elimina plugins de terceros que no necesites versionar"
echo "   2. Revisa $EXPORT_DIR/themes/ - Elimina temas que no sean custom"
echo "   3. Para imágenes: Copia manualmente las importantes (logo, favicon, etc.) a uploads-referencia/"
echo "   4. git add wp-content-custom/"
echo "   5. git commit -m 'feat: agregar contenido custom de WordPress'"
