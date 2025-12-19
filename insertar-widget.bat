@echo off
setlocal enabledelayedexpansion

cls

echo ==================================================
echo   INSERTAR WIDGET DE BUSQUEDA
echo ==================================================
echo.

echo Insertando widget en la página principal...
echo.

REM Copiar el script PHP al contenedor
docker-compose cp insertar-widget.php wordpress:/var/www/html/

REM Ejecutar el script dentro del contenedor
docker-compose exec -T wordpress php /var/www/html/insertar-widget.php

if errorlevel 1 (
    echo.
    echo ❌ Error al insertar el widget
    echo.
    echo Intenta manualmente:
    echo 1. Ve a http://localhost:8080/wp-admin
    echo 2. Páginas ^→ Todas las páginas
    echo 3. Busca la página ID 1317
    echo 4. Haz clic en "Editar con Elementor" o "Editar"
    echo 5. Añade un bloque HTML personalizado
    echo 6. Pega el código del widget
    echo 7. Guarda
    echo.
) else (
    echo.
    echo ✅ Widget insertado correctamente
    echo.
    echo Próximos pasos:
    echo 1. Abre http://localhost:8080
    echo 2. Recarga con Ctrl+F5
    echo 3. El widget debería aparecer en la página
    echo.
)

pause
