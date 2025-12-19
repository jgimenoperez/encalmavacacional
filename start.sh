#!/bin/bash

# Script para iniciar el entorno Docker de WordPress 6.9

echo "=================================================="
echo "  INICIANDO ENCALMA VACACIONAL - WordPress 6.9"
echo "=================================================="
echo ""

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Por favor, instálalo primero."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose no está instalado. Por favor, instálalo primero."
    exit 1
fi

echo "✅ Docker y Docker Compose detectados"
echo ""

# Crear volúmenes si es necesario
echo "📦 Creando volúmenes..."
docker volume create encalma_wordpress 2>/dev/null || true
docker volume create encalma_db 2>/dev/null || true

# Iniciar los contenedores
echo "🚀 Iniciando contenedores..."
docker-compose up -d

echo ""
echo "=================================================="
echo "  ✅ CONTENEDORES INICIADOS CORRECTAMENTE"
echo "=================================================="
echo ""
echo "📍 URLs de acceso:"
echo "   - WordPress:   http://localhost:8080"
echo "   - PHPMyAdmin:  http://localhost:8081"
echo "   - MySQL:       localhost:3306"
echo ""
echo "🔐 Credenciales MySQL:"
echo "   - Usuario:     wordpress_user"
echo "   - Contraseña:  wordpress_password"
echo "   - BD:          wordpress_db"
echo ""
echo "⏳ Espera 30-60 segundos para que WordPress se configure..."
echo ""
echo "📥 Próximos pasos:"
echo "   1. Accede a http://localhost:8080"
echo "   2. Configura WordPress (usuario, correo, etc.)"
echo "   3. Ve a Herramientas → Importar"
echo "   4. Instala el importador de WordPress"
echo "   5. Sube el archivo: encalmavacacional.WordPress.2025-12-11.xml"
echo ""
echo "Para detener los contenedores:"
echo "   docker-compose down"
echo ""
echo "Para ver los logs:"
echo "   docker-compose logs -f wordpress"
echo ""