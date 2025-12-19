@echo off
setlocal enabledelayedexpansion

cls

echo ==================================================
echo   REPARANDO MENUS DE WORDPRESS
echo ==================================================
echo.

REM Ejecutar el script bash dentro del contenedor
echo Conectando a la base de datos...
echo.

docker-compose exec -T db mysql -u wordpress_user -pwordpress_password wordpress_db -e "SELECT @menu_id := term_id FROM wp_terms WHERE name = 'Main Menu' LIMIT 1; UPDATE wp_options SET option_value = CONCAT('a:2:{s:13:\"primary-menu\";i:', @menu_id, ';s:12:\"mobile-menu\";i:', @menu_id, ';}') WHERE option_name = 'nav_menu_locations'; INSERT INTO wp_options (option_name, option_value, autoload) VALUES ('nav_menu_locations', CONCAT('a:2:{s:13:\"primary-menu\";i:', @menu_id, ';s:12:\"mobile-menu\";i:', @menu_id, ';}'), 'yes') ON DUPLICATE KEY UPDATE option_value = CONCAT('a:2:{s:13:\"primary-menu\";i:', @menu_id, ';s:12:\"mobile-menu\";i:', @menu_id, ';}'); DELETE FROM wp_options WHERE option_name LIKE '%%transient%%menu%%';"

if errorlevel 1 (
    echo.
    echo ❌ Error al reparar los menus
    echo.
    echo Intenta manualmente:
    echo 1. Ve a http://localhost:8080/wp-admin
    echo 2. Apariencia ^→ Menus
    echo 3. Haz clic en "Gestionar ubicaciones"
    echo 4. Asigna "Main Menu" a "Primary Menu"
    echo 5. Guarda los cambios
    echo.
) else (
    echo.
    echo ✅ Menus reparados correctamente
    echo.
    echo Próximos pasos:
    echo 1. Abre http://localhost:8080
    echo 2. El menu debería aparecer en la parte superior
    echo 3. Si no aparece, recarga la página (Ctrl+F5)
    echo.
)

pause
