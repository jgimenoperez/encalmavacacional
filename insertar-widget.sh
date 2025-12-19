#!/bin/bash

# Script para insertar el widget de búsqueda en la página principal

echo "=================================================="
echo "  INSERTAR WIDGET DE BÚSQUEDA"
echo "=================================================="
echo ""

# Copiar el script PHP al contenedor
docker-compose cp insertar-widget.php wordpress:/var/www/html/

# Ejecutar el script dentro del contenedor
docker-compose exec wordpress php /var/www/html/insertar-widget.php

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Widget insertado correctamente"
    echo ""
    echo "Próximos pasos:"
    echo "  1. Abre http://localhost:8080"
    echo "  2. Recarga con Ctrl+F5"
    echo "  3. El widget debería aparecer en la página"
    echo ""
else
    echo ""
    echo "❌ Error al insertar el widget"
    echo ""
fi
