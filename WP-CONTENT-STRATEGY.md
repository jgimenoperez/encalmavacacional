# Estrategia de Contenido WordPress

## 📁 Estructura de wp-content

```
wordpress_data/wp-content/
├── plugins/              # Plugins (mezcla de terceros + custom)
├── themes/               # Temas (mezcla de terceros + custom)
├── uploads/              # Imágenes, medios, documentos
├── languages/            # Traducciones
└── ...
```

## ✅ QUÉ VERSIONAR EN GIT

### 1. **Plugins Custom**
Tus plugins desarrollados por ti mismo.

```
wp-content-custom/plugins/
├── mi-plugin-custom/
│   ├── mi-plugin-custom.php
│   ├── includes/
│   ├── css/
│   ├── js/
│   ├── admin/
│   └── readme.txt
└── otro-plugin-mio/
```

**Cómo identificar:**
- Archivos que TÚ creaste
- No están en los repositorios oficiales de WordPress.org
- Funcionan solo para tu sitio

**Ejemplo de commit:**
```bash
git add wp-content-custom/plugins/mi-plugin-custom/
git commit -m "feat: agregar plugin custom 'Búsqueda Avanzada'"
```

### 2. **Temas Custom**
Tus temas desarrollados por ti mismo (child themes, temas custom, etc.)

```
wp-content-custom/themes/
├── mi-tema-custom/
│   ├── style.css
│   ├── functions.php
│   ├── template-parts/
│   ├── css/
│   ├── js/
│   ├── assets/
│   └── screenshot.png
└── otro-tema-mio/
```

**Cómo identificar:**
- Archivos que TÚ creaste o modificaste
- No son temas oficiales de WordPress.org
- Tienen tu lógica personalizada

**Ejemplo de commit:**
```bash
git add wp-content-custom/themes/mi-tema-custom/
git commit -m "feat: agregar tema custom 'En Calma'"
```

### 3. **Imágenes Críticas (Referencia)**
Solo logos, favicons, imágenes de marca que son POCAS y IMPORTANTES.

```
wp-content-custom/uploads-referencia/
├── logo.png
├── favicon.ico
├── hero-banner-home.jpg
└── watermark.png
```

**Criterio:**
- Máximo 10-20 imágenes
- Que se usen en el tema/marca
- Que sean pequeñas (<500KB en total)

---

## ❌ QUÉ NO VERSIONAR EN GIT

### 1. **Plugins de Terceros**
```
❌ NO VERSIONAR:
wp-content/plugins/woocommerce/
wp-content/plugins/yoast-seo/
wp-content/plugins/contact-form-7/
wp-content/plugins/elementor/
```

**Por qué:**
- Son muy grandes
- Se descargan automáticamente con `wp plugin install`
- Actualizaciones frecuentes
- Se versionan en otros repos

**Cómo recuperarlos:**
```bash
# Documentar en archivo
cat > wp-plugins-required.txt << 'EOF'
woocommerce
yoast-seo
contact-form-7
elementor
hello-dolly
EOF

# Instalar
while read plugin; do
  docker exec encalma_wordpress wp plugin install "$plugin"
done < wp-plugins-required.txt
```

### 2. **Temas de Terceros**
```
❌ NO VERSIONAR:
wp-content/themes/twentytwentyfour/
wp-content/themes/twentytwentythree/
wp-content/themes/astra/
wp-content/themes/hello/
```

**Por qué:** Mismo motivo que plugins.

**Cómo recuperarlos:**
```bash
docker exec encalma_wordpress wp theme install astra --activate
```

### 3. **Uploads (Imágenes/Medios)**
```
❌ NO VERSIONAR:
wp-content/uploads/2025/12/
wp-content/uploads/2025/11/
wp-content/uploads/gravity_forms/
```

**Por qué:**
- Generados dinámicamente por WordPress
- Pueden ser muy grandes
- Cambian constantemente
- Se multiplican rápidamente

**Soluciones:**
- **Desarrollo local:** No los necesitas versionar
- **Backup:** `bash scripts/backup-docker.sh`
- **Producción:** Almacenar en CDN (Cloudinary, AWS S3, etc.)
- **Sincronizar:** Script separado para copiar desde servidor

---

## 📋 Workflow Recomendado

### Paso 1: Exportar contenido actual
```bash
bash scripts/export-wp-content.sh
```

### Paso 2: Limpiar
```bash
# Revisar qué se exportó
ls -la wp-content-custom/plugins/
ls -la wp-content-custom/themes/
ls -la wp-content-custom/uploads-referencia/

# ELIMINAR plugins de terceros de wp-content-custom/plugins/
rm -rf wp-content-custom/plugins/woocommerce
rm -rf wp-content-custom/plugins/yoast-seo
# ... etc

# ELIMINAR temas de terceros de wp-content-custom/themes/
rm -rf wp-content-custom/themes/twentytwentyfour
# ... etc

# DEJAR SOLO tus custom
```

### Paso 3: Versionar
```bash
git add wp-content-custom/
git commit -m "feat: agregar plugins y temas custom"
git push origin main
```

### Paso 4: Documentar dependencias
```bash
# Crear lista de plugins/temas de terceros necesarios
cat > wp-plugins-required.txt << 'EOF'
# Plugins de terceros necesarios
woocommerce
yoast-seo
contact-form-7
EOF

cat > wp-themes-required.txt << 'EOF'
# Temas de terceros necesarios
astra
hello
EOF

git add wp-*-required.txt
git commit -m "docs: documentar dependencias de plugins y temas"
```

---

## 🔄 Recuperar en Máquina Nueva

### Opción 1: Instalación limpia + restaurar BD
```bash
# 1. Clonar repo
git clone <repo>

# 2. Levantar Docker
docker-compose up -d

# 3. Instalar plugins/temas de terceros
while read plugin; do
  docker exec encalma_wordpress wp plugin install "$plugin"
done < wp-plugins-required.txt

# 4. Copiar plugins/temas custom
docker cp wp-content-custom/plugins/. encalma_wordpress:/var/www/html/wp-content/plugins/
docker cp wp-content-custom/themes/. encalma_wordpress:/var/www/html/wp-content/themes/
docker cp wp-content-custom/uploads-referencia/. encalma_wordpress:/var/www/html/wp-content/uploads/

# 5. Restaurar BD
docker exec -i encalma_db mysql -u wordpress_user -pwordpress_password wordpress_db < backups/database.sql
```

### Opción 2: Desde backup completo
```bash
# Usar script de restauración
bash scripts/restore-docker.sh ./backups/2025-12-19_10-30-45
```

---

## 💡 Tips

1. **Hacer commits frecuentes** de cambios en plugins/temas custom
2. **Documentar cambios importantes** en README.md
3. **Mantener actualizada la lista de dependencias** (wp-plugins-required.txt)
4. **Hacer backups periódicos** de uploads (fuera de Git)
5. **Usar CDN para imágenes** en producción

---

## 📊 Resumen

| Qué | Dónde | Git | Frecuencia |
|-----|-------|-----|-----------|
| Plugins custom | `wp-content-custom/plugins/` | ✅ | Cuando cambias |
| Temas custom | `wp-content-custom/themes/` | ✅ | Cuando cambias |
| Imágenes críticas | `wp-content-custom/uploads-referencia/` | ✅ | Pocas |
| Plugins terceros | `wp-plugins-required.txt` | ✅ | Cuando agregas |
| Temas terceros | `wp-themes-required.txt` | ✅ | Cuando agregas |
| Uploads completos | Backup externo | ❌ | Periódico |
| BD | Backup SQL | ❌ | Periódico |

