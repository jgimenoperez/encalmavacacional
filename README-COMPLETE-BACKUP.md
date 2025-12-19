# Guía Completa de Backup y Versionado - En Calma Vacacional

## 🎯 Objetivo

Versionar en Git:
- ✅ Base de datos (estructura)
- ✅ Plugins custom
- ✅ Temas custom
- ✅ Imágenes críticas
- ✅ Configuración Docker
- ✅ Scripts de utilidad

Hacer backups externos de:
- 📦 BD completa (con datos)
- 🖼️ Todas las imágenes/uploads
- 🔌 Plugins terceros (vía wp-plugins-required.txt)
- 🎨 Temas terceros (vía wp-themes-required.txt)

---

## 📋 Estructura de Directorios

```
En_Calma_Vacacional/
│
├── 📁 docker-compose.yml              # Configuración Docker
├── 📁 php.ini                          # Configuración PHP
├── 📁 .env                             # Variables (NO VERSIONAR)
├── 📁 .env.example                     # Template de .env
├── 📁 .gitignore                       # Archivos a ignorar
│
├── 📁 scripts/                         # Scripts de utilidad
│   ├── backup-docker.sh                # Backup BD + export XML
│   ├── restore-docker.sh               # Restaurar backup
│   ├── export-db-structure.sh          # Exportar estructura BD
│   ├── export-wp-content.sh            # Exportar plugins/temas
│   ├── copy-custom-content.sh          # Copiar custom desde Docker
│   ├── install-wp-plugins.sh           # Instalar plugins terceros
│   └── install-wp-themes.sh            # Instalar temas terceros
│
├── 📁 wp-content-custom/               # Contenido personalizado
│   ├── plugins/                        # Tus plugins custom
│   ├── themes/                         # Tus temas custom
│   └── uploads-referencia/             # Imágenes críticas
│
├── 📁 plugins-custom/                  # Plugins en desarrollo
│   └── .gitkeep
│
├── 📁 themes-custom/                   # Temas en desarrollo
│   └── .gitkeep
│
├── 📁 sql-exports/                     # Exportaciones de BD
│   └── estructura-db-*.sql             # Estructura (sin datos)
│
├── 📁 backups/                         # Backups completos (NO GIT)
│   └── 2025-12-19_10-30-45/
│       ├── database.sql                # BD completa
│       └── export.xml                  # Contenido de WP
│
├── 📁 wordpress-config/                # Configuración WP
│   └── wp-config-sample.php
│
├── 📄 wp-plugins-required.txt          # Lista de plugins terceros
├── 📄 wp-themes-required.txt           # Lista de temas terceros
│
├── 📚 BACKUP_GIT_STRATEGY.md           # Estrategia de backup
├── 📚 README-GIT-WORKFLOW.md           # Workflow con Git
├── 📚 WP-CONTENT-STRATEGY.md           # Estrategia de contenido
└── 📚 README-COMPLETE-BACKUP.md        # Esta guía
```

---

## 🚀 Workflow Rápido

### Primera vez - Configurar todo

```bash
# 1. Exportar estructura de BD
bash scripts/export-db-structure.sh

# 2. Copiar plugins/temas custom desde Docker
bash scripts/copy-custom-content.sh
# Luego revisar y eliminar terceros manualmente

# 3. Hacer backup completo
bash scripts/backup-docker.sh
# Guardar en Google Drive / S3 / servidor

# 4. Versionar en Git
git add .
git commit -m "feat: configurar backup y versionado"
git push origin main
```

### Día a día - Desarrollo

```bash
# Desarrollar plugins/temas en wp-content-custom/

# Cuando termines, versionar:
git add wp-content-custom/
git commit -m "feat: actualizar plugin custom 'xxx'"
git push origin main

# Backup periódico (ej: fin de semana):
bash scripts/backup-docker.sh
# Copiar backup a Google Drive
```

### Restaurar en máquina nueva

```bash
# 1. Clonar repo
git clone <repo>

# 2. Configurar .env
cp .env.example .env
# Editar .env con valores correctos

# 3. Levantar Docker
docker-compose up -d

# 4. Instalar dependencias de terceros
bash scripts/install-wp-plugins.sh
bash scripts/install-wp-themes.sh

# 5. Copiar contenido custom
docker cp wp-content-custom/plugins/. encalma_wordpress:/var/www/html/wp-content/plugins/
docker cp wp-content-custom/themes/. encalma_wordpress:/var/www/html/wp-content/themes/
docker cp wp-content-custom/uploads-referencia/. encalma_wordpress:/var/www/html/wp-content/uploads/

# 6. Restaurar BD (si tienes backup)
bash scripts/restore-docker.sh ./backups/2025-12-19_10-30-45
```

---

## 📊 Qué Versionar vs Qué Hacer Backup

### ✅ VERSIONAR EN GIT

| Qué | Dónde | Script |
|-----|-------|--------|
| Estructura BD | `sql-exports/estructura-db-*.sql` | `export-db-structure.sh` |
| Plugins custom | `wp-content-custom/plugins/` | Manual |
| Temas custom | `wp-content-custom/themes/` | Manual |
| Imágenes críticas | `wp-content-custom/uploads-referencia/` | Manual |
| Plugins terceros | `wp-plugins-required.txt` | Manual |
| Temas terceros | `wp-themes-required.txt` | Manual |
| Configuración | `docker-compose.yml`, `php.ini` | - |
| Scripts | `scripts/*.sh` | - |

### 📦 HACER BACKUP EXTERNO (No Git)

| Qué | Dónde | Script | Frecuencia |
|-----|-------|--------|-----------|
| BD completa | `backups/*/database.sql` | `backup-docker.sh` | Semanal |
| Contenido WP | `backups/*/export.xml` | `backup-docker.sh` | Semanal |
| Uploads completos | Google Drive / S3 | Sincronización | Semanal |
| Certificados | Seguridad | Manual | Único |

---

## 🔍 Detailed Explanation de Cada Script

### 1. **export-db-structure.sh**
```bash
bash scripts/export-db-structure.sh
```
- Exporta SOLO la **estructura** de las tablas (sin datos)
- Guarda en `sql-exports/estructura-db-YYYY-MM-DD.sql`
- **Versiona en Git** para referencia
- Muy pequeño (KB)

### 2. **backup-docker.sh**
```bash
bash scripts/backup-docker.sh
```
- Exporta **BD completa + contenido XML**
- Guarda en `backups/YYYY-MM-DD_HH-MM-SS/`
- **NO versiona en Git** (demasiado grande)
- Guardar en Google Drive / S3 manualmente
- Incluye:
  - `database.sql` - BD completa con datos
  - `export.xml` - Contenido de WordPress

### 3. **restore-docker.sh**
```bash
bash scripts/restore-docker.sh ./backups/2025-12-19_10-30-45
```
- Restaura BD + contenido desde backup
- Úsalo para recuperarte de desastres
- Requiere que el backup exista

### 4. **export-wp-content.sh**
```bash
bash scripts/export-wp-content.sh
```
- Copia **plugins y temas** desde Docker
- Guarda en `wp-content-custom/` (temporal)
- Luego debes **eliminar manualmente** los de terceros
- Muestra lista de imágenes importantes

### 5. **copy-custom-content.sh**
```bash
bash scripts/copy-custom-content.sh
```
- Versión mejorada de export-wp-content.sh
- Copia a directorios temporales para revisión
- Da instrucciones paso a paso

### 6. **install-wp-plugins.sh**
```bash
bash scripts/install-wp-plugins.sh
```
- Lee `wp-plugins-required.txt`
- Instala automáticamente cada plugin
- Útil para restauración automática

### 7. **install-wp-themes.sh**
```bash
bash scripts/install-wp-themes.sh
```
- Lee `wp-themes-required.txt`
- Instala automáticamente cada tema
- Útil para restauración automática

---

## 📝 Ejemplos Prácticos

### Ejemplo 1: Agregar plugin custom y versionar

```bash
# 1. Crear plugin
mkdir -p wp-content-custom/plugins/mi-plugin-busqueda
cat > wp-content-custom/plugins/mi-plugin-busqueda/plugin.php << 'EOF'
<?php
/**
 * Plugin Name: Búsqueda Avanzada
 * Description: Plugin custom de búsqueda
 * Version: 1.0.0
 */

// Tu código aquí
EOF

# 2. Probar en Docker
docker cp wp-content-custom/plugins/mi-plugin-busqueda/. encalma_wordpress:/var/www/html/wp-content/plugins/mi-plugin-busqueda/
docker exec encalma_wordpress wp plugin activate mi-plugin-busqueda

# 3. Versionar
git add wp-content-custom/plugins/mi-plugin-busqueda/
git commit -m "feat: agregar plugin custom 'Búsqueda Avanzada'"
git push origin main
```

### Ejemplo 2: Hacer backup y guardarlo en Google Drive

```bash
# 1. Hacer backup
bash scripts/backup-docker.sh
# Crea: ./backups/2025-12-19_10-30-45/

# 2. Comprimir
cd backups
tar -czf backup-2025-12-19.tar.gz 2025-12-19_10-30-45/

# 3. Subir a Google Drive manualmente
# O usar:
# gdrive upload backup-2025-12-19.tar.gz
```

### Ejemplo 3: Documentar plugins de terceros

```bash
# 1. Ver qué plugins tengo activos
docker exec encalma_wordpress wp plugin list

# 2. Documentar en wp-plugins-required.txt
cat > wp-plugins-required.txt << 'EOF'
# Plugins principales
woocommerce
yoast-seo
contact-form-7

# Plugins de seguridad
wordfence
all-in-one-wp-security-and-firewall

# Plugins de performance
w3-total-cache
EOF

# 3. Versionar
git add wp-plugins-required.txt
git commit -m "docs: documentar plugins de terceros"
git push origin main
```

### Ejemplo 4: Restaurar todo en máquina nueva

```bash
# 1. En máquina nueva
git clone https://github.com/tu-usuario/En_Calma_Vacacional.git
cd En_Calma_Vacacional

# 2. Configurar
cp .env.example .env
# Editar .env...

# 3. Levantar Docker
docker-compose up -d
sleep 10  # Esperar a que se inicie

# 4. Instalar dependencias
bash scripts/install-wp-plugins.sh
bash scripts/install-wp-themes.sh

# 5. Copiar custom
docker cp wp-content-custom/plugins/. encalma_wordpress:/var/www/html/wp-content/plugins/
docker cp wp-content-custom/themes/. encalma_wordpress:/var/www/html/wp-content/themes/
docker cp wp-content-custom/uploads-referencia/. encalma_wordpress:/var/www/html/wp-content/uploads/

# 6. Restaurar BD
# (Descargar backup desde Google Drive primero)
bash scripts/restore-docker.sh ./backups/2025-12-19_10-30-45

# 7. Verificar
# Ir a http://localhost:8080
```

---

## ⚠️ Cosas Importantes

### NUNCA hacer

```bash
# ❌ Versionar BD completa
git add backups/
git add *.sql

# ❌ Versionar .env con credenciales
git add .env

# ❌ Versionar uploads enormes
git add wp-content/uploads/

# ❌ Versionar plugins de terceros
git add wordpress_data/wp-content/plugins/woocommerce/
```

### SIEMPRE hacer

```bash
# ✅ Versionar estructura de BD
git add sql-exports/estructura-db-*.sql

# ✅ Versionar .env.example
git add .env.example

# ✅ Hacer backups periódicos
bash scripts/backup-docker.sh

# ✅ Documentar dependencias
git add wp-plugins-required.txt wp-themes-required.txt

# ✅ Versionar plugins/temas custom
git add wp-content-custom/plugins/
git add wp-content-custom/themes/
```

---

## 🔐 Seguridad

1. **NUNCA commitar credenciales**
   - `.env` (usa `.env.example`)
   - `wp-config.php` con valores reales
   - Certificados privados

2. **Proteger backups**
   - Encriptar backups en tránsito
   - Guardar en almacenamiento seguro
   - Restringir acceso

3. **Actualizar dependencias**
   - Mantener plugins/temas de terceros actualizados
   - Revisar seguridad regularmente

---

## 📚 Archivos de Referencia

1. **BACKUP_GIT_STRATEGY.md** - Estrategia general
2. **README-GIT-WORKFLOW.md** - Workflow con Git
3. **WP-CONTENT-STRATEGY.md** - Detalles de contenido
4. **README-COMPLETE-BACKUP.md** - Esta guía

---

## 💡 Resumen Rápido

```
DESARROLLO LOCAL
├── Editar código en wp-content-custom/
├── Probar en Docker (http://localhost:8080)
├── Versionar cambios (git add/commit/push)
└── Hacer backup periódico (bash scripts/backup-docker.sh)

RESTAURACIÓN EN OTRA MÁQUINA
├── git clone
├── cp .env.example .env (editar)
├── docker-compose up -d
├── bash scripts/install-wp-plugins.sh
├── bash scripts/install-wp-themes.sh
├── docker cp wp-content-custom/* ...
└── bash scripts/restore-docker.sh <backup-dir>

BACKUP EXTERNO
├── bash scripts/backup-docker.sh
└── Guardar en Google Drive / S3 / servidor
```

¡Listo! Ya tienes una estrategia completa de backup y versionado. 🎉

