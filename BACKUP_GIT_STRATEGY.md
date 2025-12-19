# Estrategia de Backup con Git

## Estructura del Repositorio

```
En_Calma_Vacacional/
├── docker-compose.yml          # Configuración Docker
├── .env                          # Variables de entorno (NO COMMITAR)
├── php.ini                       # Configuración PHP
├── .gitignore                    # Archivos a ignorar
│
├── wordpress-config/             # Configuración de WP
│   └── wp-config-sample.php     # Template (para restauración)
│
├── plugins-custom/               # Plugins desarrollados por ti
│   └── mi-plugin/
│       ├── mi-plugin.php
│       └── ...
│
├── themes-custom/                # Temas desarrollados por ti
│   └── mi-tema/
│       ├── style.css
│       ├── functions.php
│       └── ...
│
├── scripts/                       # Scripts de utilidad
│   ├── backup-docker.sh          # Script de backup
│   ├── restore-docker.sh         # Script de restauración
│   └── export-db.sh              # Exportar BD
│
└── sql-exports/                  # Exportaciones de BD (para referencia)
    └── estructura-db.sql         # Solo estructura, sin datos
```

## Qué versionar en Git ✅

1. **Código personalizado**
   - Plugins custom en `plugins-custom/`
   - Temas custom en `themes-custom/`
   - Funciones personalizadas

2. **Configuración**
   - `docker-compose.yml`
   - `php.ini`
   - `.env` template (sin valores sensibles)
   - `wp-config-sample.php`

3. **Scripts**
   - Scripts de backup
   - Scripts de utilidad

4. **Documentación**
   - README
   - Guías de instalación
   - Cambios importantes

## Qué NO versionar en Git ❌

1. **Datos dinámicos**
   - `wordpress_data/` (volumen)
   - `db_data/` (volumen)
   - Uploads e imágenes (usa CDN o backup separado)

2. **Información sensible**
   - `.env` (valores reales)
   - `wp-config.php` (valores reales)
   - Certificados SSL

3. **Plugins/Temas de terceros**
   - Descárgalos en desarrollo con WP-CLI
   - O documenta en `composer.json` / `package.json`

## Workflow Recomendado

### 1. Estructura inicial (.env template)
```bash
cp .env.example .env
# Editar .env con valores locales (NO commitar)
```

### 2. Backup de la BD (para referencia)
```bash
docker exec encalma_db mysqldump -u wordpress_user -pwordpress_password \
  --no-data wordpress_db > sql-exports/estructura-db.sql
git add sql-exports/estructura-db.sql
git commit -m "docs: estructura de BD"
```

### 3. Exportar datos importantes (XML de WP)
```bash
# En WordPress: Herramientas → Exportar
# O con WP-CLI:
docker exec encalma_wordpress wp export > backups/export.xml
```

### 4. Commits regulares
```bash
git add plugins-custom/ themes-custom/ scripts/
git commit -m "feat: actualización de plugins/temas custom"
git push origin main
```

## Restauración en una Máquina Nueva

```bash
# 1. Clonar el repo
git clone <repo-url>
cd En_Calma_Vacacional

# 2. Configurar .env
cp .env.example .env
# Editar .env con valores correctos

# 3. Descargar datos desde backup (GCS, S3, etc.)
# O restaurar desde otra máquina

# 4. Levantar Docker
docker-compose up -d

# 5. Si necesitas plugins/temas de terceros:
docker exec encalma_wordpress wp plugin install hello-dolly --activate
```

## Backup Completo (Fuera de Git)

Para backups completos (BD + archivos), guarda en:
- Google Drive
- AWS S3
- Dropbox
- Servidor externo

**Comando para backup completo:**
```bash
#!/bin/bash
docker exec encalma_db mysqldump -u wordpress_user -pwordpress_password wordpress_db > backup-bd.sql
docker cp encalma_wordpress:/var/www/html ./wordpress-full-backup
tar -czf backup-$(date +%Y%m%d).tar.gz backup-bd.sql wordpress-full-backup/
# Subir a Google Drive / S3 / etc
```

## Resumen

- **Git**: Código, configuración, scripts, documentación
- **Backups externos**: BD completa, uploads, archivos generados
- **Volúmenes Docker**: Solo durante desarrollo local
