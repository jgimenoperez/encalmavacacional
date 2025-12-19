# 🏠 Cambiar la Página Principal a una Página Estática

El home actualmente muestra las entradas del blog, pero quieres que muestre una página específica (ID 1317).

---

## ✅ Solución Automática (Recomendado)

### En Windows:
```bash
cambiar-home.bat
```

### En Linux/Mac:
```bash
chmod +x cambiar-home.sh && docker-compose exec wordpress bash -c './cambiar-home.sh'
```

Este script automáticamente:
1. Encontrará la página con ID 1317
2. La establecerá como página principal (home)
3. Deshabilitará el blog del home

**Luego:**
1. Abre http://localhost:8080
2. Debería mostrar el contenido de la página 1317

---

## 🔧 Solución Manual (Más Control)

### Paso 1: Identifica la Página Correcta

1. Ve a **http://localhost:8080/wp-admin**
2. Ve a **Páginas** → **Todas las páginas**
3. Busca la página con ID 1317
4. Verifica que sea el home/inicio correcto

**Para encontrar el ID:**
- En la lista de páginas, pasa el cursor sobre el título
- En la barra de estado inferior verás: `http://localhost:8080/wp-admin/post.php?post=1317`
- El número después de `post=` es el ID

### Paso 2: Configura WordPress para Usar una Página Estática como Home

1. Ve a **Ajustes** → **Lectura**

Verás algo así:

```
┌────────────────────────────────────────────────┐
│ Ajustes de Lectura                             │
├────────────────────────────────────────────────┤
│                                                │
│ □ Blog de inicio (defecto)                    │
│ ◉ Una página estática                         │
│                                                │
│ Página principal:  ┌──────────────────────┐  │
│                    │ Selecciona...         │  │
│                    │ Inicio                │  │
│                    │ Sobre Nosotros        │  │
│                    │ Contacto              │  │
│                    │ Apartamentos          │  │
│                    └──────────────────────┘  │
│                                                │
│ Página de entradas: ┌────────────────────┐   │
│                     │ --- Selecciona ---  │   │
│                     │ Blog                │   │
│                     │ Noticias            │   │
│                     └────────────────────┘   │
│                                                │
│         [ Guardar cambios ]                   │
└────────────────────────────────────────────────┘
```

### Paso 3: Selecciona la Página Estática

1. Marca la opción **"Una página estática"**
2. En "Página principal", haz clic en el dropdown
3. Busca y selecciona la página que contiene el home (debería ser la página con ID 1317)
4. En "Página de entradas", selecciona dónde mostrar el blog (opcional)

### Paso 4: Guarda los Cambios

1. Haz clic en **Guardar cambios** (botón azul)
2. Verás un mensaje de confirmación

### Paso 5: Verifica

1. Abre en una nueva pestaña: **http://localhost:8080**
2. Recarga con **Ctrl+F5**
3. Debería mostrar el contenido de la página 1317

---

## 🔍 Verificación Técnica

Para verificar que está configurado correctamente desde la BD:

```sql
SELECT option_name, option_value
FROM wp_options
WHERE option_name IN ('page_on_front', 'show_on_front', 'page_for_posts');
```

Los valores correctos deben ser:
- `show_on_front`: `page`
- `page_on_front`: `1317` (o el ID de tu página principal)
- `page_for_posts`: (vacío o el ID del blog si existe)

---

## 📝 Qué Pasa Después

**Antes (Configuración Actual):**
```
http://localhost:8080/  →  Blog (últimas entradas)
```

**Después (Lo que quieres):**
```
http://localhost:8080/  →  Página estática ID 1317
http://localhost:8080/?page_id=1317  →  Misma página
http://localhost:8080/blog/  →  Blog (si lo configuras)
```

---

## 🚨 Si No Funciona

### Problema: No se ve la opción "Una página estática"

**Solución:**
1. Ve a **Páginas** → **Todas las páginas**
2. Verifica que exista al menos una página
3. Si no hay páginas, crea una:
   - Haz clic en **Añadir nueva**
   - Título: "Inicio"
   - Contenido: Añade algo (puede estar vacío)
   - Haz clic en **Publicar**
4. Vuelve a Ajustes → Lectura

### Problema: El dropdown no muestra la página 1317

**Solución:**
1. La página puede estar en estado "Borrador"
2. Ve a **Páginas** → **Todas las páginas**
3. Busca la página
4. Si está en "Borrador", haz clic en **Editar**
5. En la esquina superior derecha, haz clic en **Publicar**
6. Vuelve a Ajustes → Lectura

### Problema: Después de cambiar, el home sigue mostrando el blog

**Soluciones:**
1. Recarga la página con **Ctrl+Shift+Delete** (limpiar caché)
2. Abre una ventana privada/incógnito
3. Limpia el caché de WordPress:
   - Ve a **Ajustes** → **Lectura**
   - Cambia el dropdown a otra página
   - Guarda
   - Vuelve a cambiar a la página correcta
   - Guarda

---

## 💡 URLs Útiles

| URL | Descripción |
|-----|------------|
| `http://localhost:8080/` | Página principal (home) |
| `http://localhost:8080/?page_id=1317` | Acceso directo a la página |
| `http://localhost:8080/wp-admin/options-reading.php` | Ajustes de Lectura |
| `http://localhost:8080/wp-admin/edit.php?post_type=page` | Lista de páginas |

---

## 🎯 Checklist

- [ ] La página 1317 existe y está publicada
- [ ] He ido a Ajustes → Lectura
- [ ] He seleccionado "Una página estática"
- [ ] He seleccionado la página 1317 como "Página principal"
- [ ] He guardado los cambios
- [ ] He recargado http://localhost:8080 (Ctrl+F5)
- [ ] El home ahora muestra la página 1317

---

**Nota:** Si la página 1317 no existe o fue eliminada durante la importación, puedes crear una nueva y establecerla como home. Asegúrate de que esté publicada (no en borrador).
