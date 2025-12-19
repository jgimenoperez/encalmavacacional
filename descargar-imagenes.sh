#!/bin/bash

# Script para descargar todas las imágenes del sitio original a WordPress

echo "=================================================="
echo "  DESCARGANDO IMÁGENES DEL SITIO ORIGINAL"
echo "=================================================="
echo ""

# URL base del sitio original
ORIGEN="https://www.encalmavacacional.com/wp-content/uploads"

# Ruta destino en WordPress
DESTINO="/var/www/html/wp-content/uploads"

# Verificar si estamos dentro del contenedor
if [ ! -d "$DESTINO" ]; then
    echo "❌ ERROR: No se encontró la carpeta $DESTINO"
    echo ""
    echo "Este script debe ejecutarse dentro del contenedor WordPress."
    echo "Uso:"
    echo "  docker-compose exec wordpress bash -c './descargar-imagenes.sh'"
    exit 1
fi

echo "📍 Origen: $ORIGEN"
echo "📍 Destino: $DESTINO"
echo ""

# Crear estructura de carpetas si no existen
echo "📁 Creando estructura de carpetas..."
mkdir -p "$DESTINO/2025/09"
mkdir -p "$DESTINO/2025/10"
mkdir -p "$DESTINO/2025/11"
mkdir -p "$DESTINO/2025/12"

# Descargar todas las imágenes
echo "⏳ Descargando imágenes (esto puede tomar varios minutos)..."
echo ""

# Opción 1: Usar wget para descargar recursivamente
wget -q --show-progress \
     -r \
     -l 3 \
     -A "*.jpg,*.jpeg,*.png,*.gif,*.webp,*.svg" \
     -nd \
     -P "$DESTINO" \
     "$ORIGEN/" 2>/dev/null

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Descarga completada"
else
    echo ""
    echo "⚠️  La descarga completó con advertencias (esto es normal)"
fi

# Verificar permisos
echo ""
echo "🔐 Configurando permisos..."
chmod -R 755 "$DESTINO"
chmod -R 755 "$DESTINO/../"

echo ""
echo "=================================================="
echo "  ✅ DESCARGA FINALIZADA"
echo "=================================================="
echo ""
echo "Próximos pasos:"
echo "  1. Ve al Dashboard de WordPress"
echo "  2. Ve a Medios → Biblioteca"
echo "  3. Instala y activa 'Regenerate Thumbnails'"
echo "  4. Ve a Herramientas → Regenerate Thumbnails"
echo "  5. Haz clic en 'Regenerate All'"
echo ""
echo "Las imágenes deberían aparecer en las páginas después"
echo "de regenerar los thumbnails."
echo ""
