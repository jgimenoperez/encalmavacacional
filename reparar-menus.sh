#!/bin/bash

# Script para reparar menús en WordPress

echo "=================================================="
echo "  REPARANDO MENÚS DE WORDPRESS"
echo "=================================================="
echo ""

# Credenciales de la BD
DB_HOST="db"
DB_USER="wordpress_user"
DB_PASSWORD="wordpress_password"
DB_NAME="wordpress_db"

echo "🔧 Reparando configuración de menús..."
echo ""

# Ejecutar el SQL directamente
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" <<EOF

-- 1. Obtener el ID del menú "Main Menu"
SELECT @menu_id := term_id FROM wp_terms WHERE name = 'Main Menu' LIMIT 1;

-- 2. Asignar el menú a la ubicación principal de Astra
UPDATE wp_options
SET option_value = CONCAT('a:2:{s:13:"primary-menu";i:', @menu_id, ';s:12:"mobile-menu";i:', @menu_id, ';}')
WHERE option_name = 'nav_menu_locations';

-- 3. Si no existe la opción, crearla
INSERT INTO wp_options (option_name, option_value, autoload)
VALUES ('nav_menu_locations', CONCAT('a:2:{s:13:"primary-menu";i:', @menu_id, ';s:12:"mobile-menu";i:', @menu_id, ';}'), 'yes')
ON DUPLICATE KEY UPDATE option_value = CONCAT('a:2:{s:13:"primary-menu";i:', @menu_id, ';s:12:"mobile-menu";i:', @menu_id, ';}');

-- 4. Limpiar caché de opciones
DELETE FROM wp_options WHERE option_name LIKE '%transient%menu%';

EOF

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Menús reparados correctamente"
    echo ""
    echo "Próximos pasos:"
    echo "  1. Abre http://localhost:8080"
    echo "  2. El menú debería aparecer en la parte superior"
    echo "  3. Si no aparece, vacía la caché del navegador (Ctrl+F5)"
    echo ""
else
    echo ""
    echo "❌ Error al reparar los menús"
    echo ""
    echo "Intenta manualmente:"
    echo "  1. Ve a Apariencia → Menús"
    echo "  2. Haz clic en 'Gestionar ubicaciones'"
    echo "  3. Asigna 'Main Menu' a 'Primary Menu'"
    echo "  4. Guarda los cambios"
    echo ""
fi
