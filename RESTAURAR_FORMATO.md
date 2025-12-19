# 🎨 Guía para Restaurar Formato e Imágenes

El contenido se importó correctamente, pero faltan:
1. **Tema**: Astra Theme
2. **Plugins**: Elementor, Contact Form 7, WP Smush (optimización de imágenes)
3. **Imágenes**: Necesitan descargarse manualmente

---

## 📋 Paso 1: Instalar el Tema Astra

1. Ve a **Apariencia** → **Temas**
2. Haz clic en **Añadir nuevo**
3. Busca: **"Astra"**
4. Haz clic en **Instalar**
5. Haz clic en **Activar**

---

## 🔌 Paso 2: Instalar Plugins Esenciales

### Plugin 1: Elementor (Constructor visual)
1. Ve a **Plugins** → **Añadir nuevo**
2. Busca: **"Elementor"**
3. Instala y activa
4. Se abrirá un asistente de bienvenida (sigue los pasos)

### Plugin 2: Contact Form 7 (Formularios)
1. Ve a **Plugins** → **Añadir nuevo**
2. Busca: **"Contact Form 7"**
3. Instala y activa

### Plugin 3: WP Smush (Optimización de imágenes)
1. Ve a **Plugins** → **Añadir nuevo**
2. Busca: **"WP Smush"**
3. Instala y activa

### Plugin 4: Yoast SEO (Meta tags y SEO)
1. Ve a **Plugins** → **Añadir nuevo**
2. Busca: **"Yoast SEO"**
3. Instala (versión gratuita)

---

## 🖼️ Paso 3: Descargar Imágenes del Sitio Original

Como WordPress no descargó automáticamente las imágenes, tienes varias opciones:

### Opción A: Script automático (Recomendado)

1. Abre **SSH/Terminal** en el contenedor WordPress
   ```bash
   docker-compose exec wordpress bash
   ```

2. Navega a wp-content:
   ```bash
   cd /var/www/html/wp-content/uploads
   ```

3. Descarga todas las imágenes desde el sitio original:
   ```bash
   wget -r -l 2 https://www.encalmavacacional.com/wp-content/uploads/
   ```

### Opción B: Plugin de descarga automática

1. Ve a **Plugins** → **Añadir nuevo**
2. Busca: **"Media Files Copier"** o **"Media Sync"**
3. Instala y activa
4. Va a **Herramientas** → **Media Files Copier**
5. Selecciona las imágenes y descárgalas

### Opción C: Manual con curl (una por una)

```bash
# Dentro del contenedor
cd /var/www/html/wp-content/uploads

# Crear estructura de carpetas
mkdir -p 2025/09

# Descargar una imagen de ejemplo
curl -o "2025/09/3-38.jpg" "https://www.encalmavacacional.com/wp-content/uploads/2025/09/3-38.jpg"
```

---

## ⚙️ Paso 4: Sincronizar la Base de Datos

Después de descargar las imágenes, WordPress necesita actualizar la BD:

1. Ve a **Medios** → **Biblioteca**
2. Haz clic en **Sincronizar archivos** (si está disponible)

O instala este plugin:
```
Plugins → Añadir nuevo → Busca "Regenerate Thumbnails"
Instala y activa
Ve a Herramientas → Regenerate Thumbnails
Haz clic en "Regenerate All"
```

---

## 🔧 Paso 5: Configurar Elementor

Después de instalar Elementor y Astra:

1. Abre una página en **Páginas** → **Todas las páginas**
2. Busca una página que tenga contenido Elementor
3. Haz clic en **Editar con Elementor**
4. Los elementos se reconstruirán automáticamente
5. Haz clic en **Actualizar**

Si las páginas no muestran contenido:
- Ve a **Página → Editar** (editor clásico)
- Verifica que el contenido de Elementor esté en el campo de contenido
- Si está vacío, puede haber sido un problema de exportación

---

## 📲 Paso 6: Reconfigurar Menús

Los menús se importaron pero pueden no estar asignados:

1. Ve a **Apariencia** → **Menús**
2. Verás "Main Menu" importado
3. Edita los elementos si es necesario
4. Ve a **Gestionar ubicaciones**
5. Asigna "Main Menu" a las localizaciones deseadas:
   - Primary Menu
   - Footer Menu
   - Mobile Menu (si existe)

---

## 🎯 Paso 7: Verificar Widgets

Los widgets se importaron en la BD pero pueden no verse:

1. Ve a **Apariencia** → **Widgets**
2. Verás los widgets importados
3. Asígnalos a las áreas de widgets del tema (Sidebar, Footer, etc.)

---

## 📝 Lista de Verificación

- [ ] Tema Astra instalado y activado
- [ ] Elementor instalado y activado
- [ ] Contact Form 7 instalado
- [ ] WP Smush instalado
- [ ] Yoast SEO instalado (opcional)
- [ ] Imágenes descargadas del sitio original
- [ ] Thumbnails regeneradas
- [ ] Menús configurados
- [ ] Widgets asignados a áreas
- [ ] Páginas muestran contenido correctamente
- [ ] Formularios de contacto funcionan

---

## 🔗 URLs de Utilidad

| Recurso | URL |
|---------|-----|
| WordPress Dashboard | http://localhost:8080/wp-admin |
| Plugins | http://localhost:8080/wp-admin/plugins.php |
| Temas | http://localhost:8080/wp-admin/themes.php |
| Medios | http://localhost:8080/wp-admin/upload.php |
| Páginas | http://localhost:8080/wp-admin/edit.php?post_type=page |
| Posts | http://localhost:8080/wp-admin/edit.php |
| Menús | http://localhost:8080/wp-admin/nav-menus.php |

---

## 🚨 Si Algo No Funciona

### Las imágenes aún no cargan
- Verifica que los archivos estén en `/var/www/html/wp-content/uploads/`
- Ejecuta "Regenerate Thumbnails"
- Comprueba los permisos: `chmod -R 755 /var/www/html/wp-content/uploads/`

### Elementor muestra "Contenido no cargado"
- Abre la página en editor Elementor
- Haz clic en **Actualizar**
- Si sigue, reinstala Elementor

### Contact Form 7 no funciona
- Verifica que el plugin esté activado
- Ve a **Contacto** → **Formularios de contacto**
- Crea un nuevo formulario o usa uno existente

### Las páginas están en blanco
- Ve a **Páginas** → Abre una página
- Cambia a "Editor visual" y luego a "Elementor"
- Guarda los cambios

---

## 💡 Tips Útiles

1. **Antes de cambiar el tema**: Haz una copia de seguridad
   - Ve a **Herramientas** → **Exportar**
   - Descarga el archivo XML

2. **Si cambias el tema**: Reinstala los plugins necesarios para ese tema

3. **Para acelerar**: Instala WP Smush para optimizar imágenes

4. **Para SEO**: Instala Yoast SEO y rellena los campos de meta descripción

---

**Fecha**: 11 de Diciembre de 2025
**Versión**: 1.0
