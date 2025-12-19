@echo off
setlocal enabledelayedexpansion

cls

echo ==================================================
echo   DESCARGANDO IMAGENES DEL SITIO ORIGINAL
echo ==================================================
echo.

REM Ejecutar script bash dentro del contenedor
echo Conectando al contenedor WordPress...
echo.

docker-compose exec wordpress bash -c "chmod +x descargar-imagenes.sh && ./descargar-imagenes.sh"

if errorlevel 1 (
    echo.
    echo ❌ Error al ejecutar la descarga
    echo.
    echo Alternativa manual:
    echo 1. Abre PowerShell o CMD
    echo 2. Ejecuta:
    echo    docker-compose exec wordpress bash
    echo 3. Luego:
    echo    cd /var/www/html/wp-content/uploads
    echo    wget -r -l 2 https://www.encalmavacacional.com/wp-content/uploads/
    echo.
) else (
    echo.
    echo ✅ Descarga completada
    echo.
    echo Próximos pasos:
    echo 1. Ve a http://localhost:8080/wp-admin
    echo 2. Plugins ^→ Añadir nuevo
    echo 3. Busca "Regenerate Thumbnails"
    echo 4. Instala y activa
    echo 5. Ve a Herramientas ^→ Regenerate Thumbnails
    echo 6. Haz clic en "Regenerate All"
    echo.
)

pause
