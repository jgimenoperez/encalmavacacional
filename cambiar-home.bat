@echo off
setlocal enabledelayedexpansion

cls

echo ==================================================
echo   CAMBIAR PAGINA PRINCIPAL A PAGINA ESTATICA
echo ==================================================
echo.

REM Usar ID de página 1317
set PAGE_ID=1317

echo Configurando página principal a ID %PAGE_ID%...
echo.

REM Ejecutar los comandos SQL en la BD
docker-compose exec -T db mysql -u wordpress_user -pwordpress_password wordpress_db -e "UPDATE wp_options SET option_value = 'page' WHERE option_name = 'show_on_front'; UPDATE wp_options SET option_value = '%PAGE_ID%' WHERE option_name = 'page_on_front';"

if errorlevel 1 (
    echo.
    echo ❌ Error al cambiar la página principal
    echo.
    echo Intenta manualmente:
    echo 1. Ve a http://localhost:8080/wp-admin
    echo 2. Ajustes ^→ Lectura
    echo 3. Marca "Una página estática"
    echo 4. En "Página principal" selecciona la página con ID 1317
    echo 5. Guarda cambios
    echo.
) else (
    echo.
    echo ✅ Página principal cambiad a ID %PAGE_ID%
    echo.
    echo Próximos pasos:
    echo 1. Abre http://localhost:8080
    echo 2. Recarga con Ctrl+F5
    echo 3. Debería mostrar la página %PAGE_ID% como home
    echo.
    echo URLs útiles:
    echo - Home: http://localhost:8080
    echo - Acceso directo: http://localhost:8080/?page_id=%PAGE_ID%
    echo.
)

pause
