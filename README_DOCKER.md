# ENCALMA VACACIONAL - Docker WordPress 6.9

Estructura Docker completa para ejecutar WordPress 6.9 con MySQL, lista para importar el contenido del sitio desde el archivo XML.

## 📋 Requisitos Previos

- **Docker**: [Descargar Docker Desktop](https://www.docker.com/products/docker-desktop)
- **Docker Compose**: Se incluye con Docker Desktop
- Mínimo 2GB de RAM disponible
- Puerto 8080 disponible (WordPress)
- Puerto 8081 disponible (PHPMyAdmin)
- Puerto 3306 disponible (MySQL)

## 🚀 Inicio Rápido

### En Windows
1. Abre PowerShell o CMD en esta carpeta
2. Ejecuta:
   ```bash
   .\start.bat
   ```

### En macOS/Linux
1. Abre una terminal en esta carpeta
2. Dale permisos al script:
   ```bash
   chmod +x start.sh
   ```
3. Ejecuta:
   ```bash
   ./start.sh
   ```

### Manual (cualquier SO)
```bash
docker-compose up -d
```

## 🌐 Acceso a los Servicios

Una vez iniciado, accede a:

| Servicio | URL | Usuario | Contraseña |
|----------|-----|---------|------------|
| WordPress | http://localhost:8080 | admin (configurable) | (configurable) |
| PHPMyAdmin | http://localhost:8081 | wordpress_user | wordpress_password |
| MySQL | localhost:3306 | wordpress_user | wordpress_password |

## 📦 Estructura de Contenedores

### 1. **MySQL 8.0** (db)
- Base de datos del sitio WordPress
- Credenciales en `.env`
- Volumen persistente: `db_data`

### 2. **WordPress 6.9** (wordpress)
- Servidor Apache + PHP
- Configuración automática con las credenciales de BD
- Volumen persistente: `wordpress_data`

### 3. **PHPMyAdmin** (phpmyadmin)
- Panel para gestionar la base de datos
- Interfaz web para ver/editar datos SQL

## 📥 Importar el Contenido XML

### Paso 1: Acceder a WordPress
1. Ve a http://localhost:8080
2. Configura WordPress con:
   - Usuario: `admin` (o el que prefieras)
   - Email: Tu correo
   - Contraseña: La que prefieras

### Paso 2: Instalar el Importador
1. Accede al panel de control de WordPress
2. Ve a **Herramientas** → **Importar**
3. Busca "WordPress" en la lista
4. Haz clic en "Instalar ahora"
5. Haz clic en "Activar complemento e importar"

### Paso 3: Subir el Archivo XML
1. Haz clic en "Elegir archivo"
2. Selecciona: `encalmavacacional.WordPress.2025-12-11.xml`
3. Haz clic en "Subir archivo e importar"

### Paso 4: Mapear Autores
Se te pedirá mapear los autores del archivo XML:
- `informatica@octplus.es` → Selecciona usuario existente o crea uno nuevo
- `Alvaro` → Selecciona usuario existente o crea uno nuevo

### Paso 5: Completar la Importación
- Marca las opciones para importar:
  - Posts y páginas
  - Comentarios
  - Categorías y etiquetas
  - Datos personalizados
- Haz clic en "Enviar"

¡Listo! Todo el contenido se importará en unos minutos.

## 🛠️ Comandos Útiles

```bash
# Ver estado de los contenedores
docker-compose ps

# Ver logs de WordPress
docker-compose logs -f wordpress

# Ver logs de MySQL
docker-compose logs -f db

# Acceder a la shell de WordPress
docker-compose exec wordpress bash

# Acceder a MySQL desde línea de comandos
docker-compose exec db mysql -u wordpress_user -pwordpress_password wordpress_db

# Detener todos los contenedores
docker-compose down

# Detener y eliminar volúmenes (⚠️ borra los datos)
docker-compose down -v

# Reiniciar los contenedores
docker-compose restart

# Rebuild de las imágenes
docker-compose build --no-cache
```

## 📁 Estructura de Archivos

```
En_Calma_Vacacional/
├── docker-compose.yml          # Configuración de Docker
├── .env                         # Variables de entorno
├── start.sh                     # Script de inicio (Linux/Mac)
├── start.bat                    # Script de inicio (Windows)
├── README_DOCKER.md             # Este archivo
├── index.html                   # Página HTML de ejemplo
├── Worpress_data/               # Datos de WordPress
│   └── encalmavacacional.WordPress.2025-12-11.xml
└── wordpress_data/              # Volumen de WordPress (se crea automáticamente)
    └── (wp-content, wp-admin, etc.)
```

## 🔐 Variables de Entorno

Se pueden modificar en el archivo `.env`:

```env
WORDPRESS_VERSION=6.9
WORDPRESS_DB_HOST=db:3306
WORDPRESS_DB_NAME=wordpress_db
WORDPRESS_DB_USER=wordpress_user
WORDPRESS_DB_PASSWORD=wordpress_password
WORDPRESS_TABLE_PREFIX=wp_

MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_DATABASE=wordpress_db
MYSQL_USER=wordpress_user
MYSQL_PASSWORD=wordpress_password

WORDPRESS_PORT=8080
PHPMYADMIN_PORT=8081
MYSQL_PORT=3306

WORDPRESS_DEBUG=true
```

**Nota:** Si modificas las variables, debes ejecutar `docker-compose down -v` y luego `docker-compose up -d` para que se apliquen.

## 🐛 Solución de Problemas

### WordPress no carga en http://localhost:8080
1. Espera 60 segundos (WordPress necesita tiempo para iniciarse)
2. Verifica los logs: `docker-compose logs -f wordpress`
3. Asegúrate de que el puerto 8080 no esté en uso

### Error de conexión a base de datos
1. Verifica que MySQL esté corriendo: `docker-compose ps`
2. Revisa los logs: `docker-compose logs -f db`
3. Asegúrate de que las credenciales en `.env` coinciden

### No puedo acceder a PHPMyAdmin
1. Verifica que el contenedor está ejecutándose: `docker-compose ps`
2. Accede a http://localhost:8081
3. Usuario: `wordpress_user`
4. Contraseña: `wordpress_password`

### El importador de WordPress no funciona
1. El archivo XML debe tener formato WXR válido
2. Comprueba que el servidor tiene suficiente memoria
3. Aumenta los límites en `wp-config.php` si es necesario

## 📊 Monitoreo

Para ver el consumo de recursos:
```bash
docker stats
```

## 🔄 Actualizar WordPress

Para actualizar a otra versión, modifica `docker-compose.yml`:
```yaml
wordpress:
  image: wordpress:X.X-apache  # Cambia aquí
```

Y luego:
```bash
docker-compose up -d --no-deps --build wordpress
```

## 🗑️ Limpiar

Para eliminar todo y empezar desde cero:
```bash
docker-compose down -v
docker volume rm encalma_wordpress encalma_db 2>/dev/null
docker-compose up -d
```

## 📝 Notas Importantes

- Los datos se persisten en volúmenes de Docker, así que no se perderán al reiniciar
- WordPress 6.9 es compatible con PHP 7.4+
- MySQL 8.0 es la base de datos recomendada para WordPress 6.9
- Se recomienda cambiar las contraseñas antes de ir a producción

## ✅ Checklist de Configuración

- [ ] Docker Desktop instalado
- [ ] Puertos 8080, 8081, 3306 disponibles
- [ ] Archivo `docker-compose.yml` presente
- [ ] Archivo `.env` presente
- [ ] Contenedores iniciados correctamente
- [ ] WordPress accesible en http://localhost:8080
- [ ] Archivo XML en `Worpress_data/`
- [ ] Importador de WordPress instalado
- [ ] Contenido importado correctamente

## 📞 Soporte

Para más ayuda:
- [Documentación de WordPress](https://wordpress.org/support/)
- [Documentación de Docker](https://docs.docker.com/)
- [Documentación de Docker Compose](https://docs.docker.com/compose/)

---

**Fecha de creación:** 11 de Diciembre de 2025
**Versión de WordPress:** 6.9
**Base de datos:** MySQL 8.0
