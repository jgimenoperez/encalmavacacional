# Workflow Git para En Calma Vacacional (WordPress Docker)

## 🎯 Objetivo

Mantener versionado en Git:
- ✅ Código custom (plugins, temas, funciones)
- ✅ Configuración Docker
- ✅ Scripts de utilidad
- ✅ Documentación

Sin versionar:
- ❌ Volúmenes Docker (BD, uploads)
- ❌ Variables sensibles
- ❌ Plugins/temas de terceros

## 🚀 Primeros Pasos

### 1. Configurar el repositorio local

```bash
# Clonar o entrar en el repo
cd En_Calma_Vacacional

# Copiar .env.example a .env (NO commitar)
cp .env.example .env

# Verificar .gitignore
cat .gitignore

# Ver estado
git status
```

### 2. Crear estructura base

La estructura ya está creada:
```
📁 plugins-custom/        # Tus plugins personalizados
📁 themes-custom/         # Tus temas personalizados
📁 scripts/              # Scripts de utilidad
📁 wordpress-config/     # Configuración
📁 sql-exports/          # Exportaciones (referencia)
📄 .env.example          # Template de .env
📄 docker-compose.yml    # Configuración Docker
📄 php.ini               # Configuración PHP
```

## 📝 Tareas Comunes

### Agregar un plugin personalizado

```bash
# 1. Crear estructura
mkdir -p plugins-custom/mi-plugin

# 2. Crear archivos
cat > plugins-custom/mi-plugin/mi-plugin.php << 'EOF'
<?php
/**
 * Plugin Name: Mi Plugin
 * Description: Descripción del plugin
 * Version: 1.0.0
 */

// Tu código aquí
EOF

# 3. Commitar
git add plugins-custom/mi-plugin/
git commit -m "feat: agregar plugin personalizado 'mi-plugin'"
git push origin main
```

### Agregar un tema personalizado

```bash
# Similar al plugin, pero en themes-custom/
mkdir -p themes-custom/mi-tema
# Agregar archivos (style.css, functions.php, index.php, etc.)
git add themes-custom/mi-tema/
git commit -m "feat: agregar tema 'mi-tema'"
```

### Hacer backup de la BD (para referencia)

```bash
# Exportar solo estructura (sin datos personales)
docker exec encalma_db mysqldump -u wordpress_user -pwordpress_password \
  --no-data wordpress_db > sql-exports/estructura-db.sql

git add sql-exports/estructura-db.sql
git commit -m "docs: actualizar estructura de BD"
git push origin main
```

### Hacer backup completo (para restauración)

```bash
# Comando directo (NO se versiona en Git)
bash scripts/backup-docker.sh

# Los archivos backup*.zip quedan en ./backups/
# Guardar en Google Drive / S3 / servidor externo
```

### Restaurar desde backup

```bash
# Si tienes un backup guardado
bash scripts/restore-docker.sh ./backups/2025-12-19_10-30-45

# O si tienes solo el export.xml, importar en WordPress
# Herramientas → Importar → Seleccionar archivo XML
```

## 🔐 Seguridad

### NUNCA commitar:
- `.env` con valores reales
- `wp-config.php` con credenciales reales
- `localhost-key.pem`, `localhost.pem` (certificados privados)
- Archivos `.sql` con datos de producción

### Siempre commitar:
- `.env.example` con placeholders
- Configuraciones públicas
- Código fuente

## 📊 Flujo típico de trabajo

```
1. Desarrollar localmente
   └─ Editar plugins/temas en plugins-custom/ themes-custom/

2. Probar en Docker
   └─ docker-compose up -d
   └─ http://localhost:8080

3. Hacer commit de cambios
   └─ git add plugins-custom/ themes-custom/
   └─ git commit -m "descripción de cambios"

4. Hacer push
   └─ git push origin main

5. Backup (opcional)
   └─ bash scripts/backup-docker.sh
   └─ Guardar en Google Drive / servidor externo

6. En otra máquina o producción
   └─ git clone <repo>
   └─ cp .env.example .env (editar con valores correctos)
   └─ docker-compose up -d
```

## 🆘 Troubleshooting

### "Git está pidiendo credenciales"
```bash
# Configurar SSH o HTTPS
git remote -v
git remote set-url origin git@github.com:tu-usuario/repo.git
```

### "¿Cómo restaurar en una máquina nueva?"
```bash
1. git clone <repo>
2. cp .env.example .env
3. Editar .env con valores correctos
4. docker-compose up -d
5. (Opcional) bash scripts/restore-docker.sh <backup-dir>
```

### "Accidentalmente commitié .env con credenciales"
```bash
# Revertir el commit
git reset HEAD~1

# O si ya está en el repo remoto
git rm --cached .env
git commit -m "fix: remove .env from tracking"
git push origin main
# Cambiar credenciales en Docker/BD después
```

## 📚 Referencias

- [BACKUP_GIT_STRATEGY.md](./BACKUP_GIT_STRATEGY.md) - Estrategia completa
- [docker-compose.yml](./docker-compose.yml) - Configuración Docker
- [scripts/](./scripts/) - Scripts de utilidad

## 💡 Tips

1. **Hacer commits frecuentes** - Cambios pequeños y descriptivos
2. **Escribir buenos mensajes** - `feat:`, `fix:`, `docs:`, `chore:`
3. **Mantener .env.example actualizado** - Si agrega variables, actualizar el template
4. **Documentar cambios importantes** - Especialmente en README.md
5. **Backup periódicos** - Aunque sea versionado, hacer backups de seguridad

## 🔄 Ejemplo: Push a producción

```bash
# En máquina de producción:
cd /var/www/wordpress

# Pull cambios
git pull origin main

# Aplicar cambios de plugins/temas
docker cp plugins-custom/. encalma_wordpress:/var/www/html/wp-content/plugins/
docker cp themes-custom/. encalma_wordpress:/var/www/html/wp-content/themes/

# (Opcional) Restaurar BD si cambió
docker exec -i encalma_db mysql -u wordpress_user -pwordpress_password wordpress_db < backup.sql
```

¡Listo! Ya tienes control de versiones completo para tu WordPress dockerizado.
