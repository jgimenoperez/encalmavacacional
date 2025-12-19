#!/bin/bash

# Script para cambiar la página principal a una página estática

echo "=================================================="
echo "  CAMBIAR PÁGINA PRINCIPAL"
echo "=================================================="
echo ""

PAGE_ID=1317

echo "🏠 Configurando página principal a ID $PAGE_ID..."
echo ""

# Credenciales de la BD
DB_HOST="db"
DB_USER="wordpress_user"
DB_PASSWORD="wordpress_password"
DB_NAME="wordpress_db"

# Ejecutar los comandos SQL
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" <<EOF

-- Cambiar a página estática
UPDATE wp_options SET option_value = 'page' WHERE option_name = 'show_on_front';

-- Establecer la página principal
UPDATE wp_options SET option_value = '$PAGE_ID' WHERE option_name = 'page_on_front';

-- Limpiar caché de transientes
DELETE FROM wp_options WHERE option_name LIKE '%transient%';

-- Verificar la configuración
SELECT CONCAT('show_on_front: ', option_value) FROM wp_options WHERE option_name = 'show_on_front';
SELECT CONCAT('page_on_front: ', option_value) FROM wp_options WHERE option_name = 'page_on_front';

EOF

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Página principal cambiada a ID $PAGE_ID"
    echo ""
    echo "Próximos pasos:"
    echo "  1. Abre http://localhost:8080"
    echo "  2. Recarga con Ctrl+F5 (o Cmd+Shift+R en Mac)"
    echo "  3. Debería mostrar la página $PAGE_ID como home"
    echo ""
    echo "URLs útiles:"
    echo "  - Home: http://localhost:8080"
    echo "  - Acceso directo: http://localhost:8080/?page_id=$PAGE_ID"
    echo ""
else
    echo ""
    echo "❌ Error al cambiar la página principal"
    echo ""
    echo "Intenta manualmente:"
    echo "  1. Ve a http://localhost:8080/wp-admin"
    echo "  2. Ajustes → Lectura"
    echo "  3. Marca 'Una página estática'"
    echo "  4. En 'Página principal' selecciona la página con ID $PAGE_ID"
    echo "  5. Guarda cambios"
    echo ""
fi
