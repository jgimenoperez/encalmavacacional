# 🔍 Añadir Widget de Búsqueda de Reservas al Home

Quieres insertar el widget de bookonline en una posición específica de la página principal (ID 1317).

---

## 📍 Opciones de Dónde Insertar

### Opción 1: Al Principio del Home (Debajo del Header)
```
┌─────────────────────────────┐
│       HEADER/LOGO           │
├─────────────────────────────┤
│  ← WIDGET DE BÚSQUEDA AQUÍ  │
├─────────────────────────────┤
│                             │
│  Contenido del home         │
│                             │
└─────────────────────────────┘
```

### Opción 2: En Medio del Home
```
┌─────────────────────────────┐
│       HEADER/LOGO           │
├─────────────────────────────┤
│                             │
│  Primera sección del home   │
│                             │
├─────────────────────────────┤
│  ← WIDGET DE BÚSQUEDA AQUÍ  │
├─────────────────────────────┤
│                             │
│  Resto del contenido        │
│                             │
└─────────────────────────────┘
```

### Opción 3: En un Bloque Específico (Más Profesional)
Crea una sección nueva solo para el widget.

---

## ✅ Solución Recomendada: Usar Elementor

Si el home está hecho con **Elementor**, esta es la forma correcta:

### Paso 1: Abre el Editor de Elementor

1. Ve a **http://localhost:8080/wp-admin**
2. Ve a **Páginas** → **Todas las páginas**
3. Busca la página con ID 1317
4. Haz clic en **Editar con Elementor**

### Paso 2: Selecciona Dónde Insertar

En el editor de Elementor:
1. Haz clic en el icono **"+"** (Agregar elemento) donde quieras insertar el widget
2. Busca **"Contenedor HTML"** o **"Custom HTML"**
3. Si no existe, usa **"Código Personalizado"** o **"Raw HTML"**

### Paso 3: Inserta el Código

En el campo HTML personalizado, pega:

```html
<!-- Widget de Búsqueda de Reservas -->
<script type="text/javascript" src="https://bookonline.pro/widgets/search/dist/index.js" defer></script>
<div data-accommodations-filter="none" data-target="_blank" class="avaibook-search-widget" data-widget-id="96718" data-widget-token="2qSUQVY/3JphKUQ7zoaDEA==" data-background-color="#FFFFFF" data-main-color="#1AB394" data-border-radius="3px" data-shadow="0 2px 20px rgb(0 0 0 / 16%)" data-padding="1rem" data-language="es"></div>
```

### Paso 4: Estiliza (Opcional)

Si quieres que el widget tenga estilos adicionales, añade CSS:

```css
.avaibook-search-widget {
  margin: 20px 0;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}
```

### Paso 5: Guarda

1. Haz clic en **Actualizar** (esquina superior derecha)
2. Ve al home: **http://localhost:8080**
3. Debería ver el widget en la posición que elegiste

---

## 🔧 Solución Alternativa: Editar el Contenido Directamente

Si el home **NO está hecho con Elementor**, edita el contenido:

### Paso 1: Abre la Página para Editar

1. Ve a **http://localhost:8080/wp-admin**
2. Ve a **Páginas** → **Todas las páginas**
3. Busca la página ID 1317
4. Haz clic en **Editar**

### Paso 2: Cambia a Editor de Código (si es necesario)

En la parte superior derecha del editor, verás opciones:
- **Visual** (WYSIWYG)
- **Código** o **HTML**

Haz clic en **Código** para ver el HTML.

### Paso 3: Encuentra la Posición Correcta

Por ejemplo, si quieres insertar después de un título `<h1>`, busca:

```html
<h1>Bienvenido a ENCALMA VACACIONAL</h1>
<!-- Insertar AQUÍ -->
```

### Paso 4: Pega el Código

Inserta entre las líneas:

```html
<h1>Bienvenido a ENCALMA VACACIONAL</h1>

<!-- Widget de Búsqueda de Reservas -->
<div style="margin: 30px 0;">
  <script type="text/javascript" src="https://bookonline.pro/widgets/search/dist/index.js" defer></script>
  <div data-accommodations-filter="none" data-target="_blank" class="avaibook-search-widget" data-widget-id="96718" data-widget-token="2qSUQVY/3JphKUQ7zoaDEA==" data-background-color="#FFFFFF" data-main-color="#1AB394" data-border-radius="3px" data-shadow="0 2px 20px rgb(0 0 0 / 16%)" data-padding="1rem" data-language="es"></div>
</div>

<!-- Resto del contenido -->
```

### Paso 5: Guarda

Haz clic en **Actualizar** y verifica en http://localhost:8080

---

## 💡 Con CSS Personalizado (Mejor Presentación)

Si quieres que el widget se vea mejor, envolverlo en un contenedor con estilos:

```html
<!-- Widget de Búsqueda de Reservas -->
<div class="widget-search-container">
  <script type="text/javascript" src="https://bookonline.pro/widgets/search/dist/index.js" defer></script>
  <div data-accommodations-filter="none" data-target="_blank" class="avaibook-search-widget" data-widget-id="96718" data-widget-token="2qSUQVY/3JphKUQ7zoaDEA==" data-background-color="#FFFFFF" data-main-color="#1AB394" data-border-radius="3px" data-shadow="0 2px 20px rgb(0 0 0 / 16%)" data-padding="1rem" data-language="es"></div>
</div>

<style>
.widget-search-container {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 40px 20px;
  margin: 30px 0;
  border-radius: 10px;
  text-align: center;
}

.widget-search-container .avaibook-search-widget {
  max-width: 600px;
  margin: 0 auto;
}
</style>
```

---

## 🎯 Pasos Resumidos

1. Ve a **Páginas** → **Todas las páginas**
2. Abre la página ID 1317
3. Si tiene Elementor, haz clic en **Editar con Elementor**
4. Inserta un bloque **HTML personalizado** donde quieras
5. Pega el código del widget
6. Haz clic en **Actualizar**
7. Verifica en http://localhost:8080

---

## 🔍 Cómo Saber Si Usa Elementor

Cuando abres la página para editar, verás:

**Si usa Elementor:**
- Un botón azul que dice **"Editar con Elementor"**
- El editor tiene bloques visuales

**Si NO usa Elementor:**
- Un editor de texto normal
- Verás un botón **"Código"** para ver HTML

---

## ⚠️ Importante

- El código del widget debe incluir TANTO el `<script>` COMO el `<div>`
- No puedes insertar solo el `<div>` sin el `<script>`
- El script debe estar en la misma página o antes del div

---

## 📝 Checklist

- [ ] Abre la página ID 1317 para editar
- [ ] Decido si usar Elementor o editor HTML
- [ ] Elijo una posición clara para el widget
- [ ] Pego el código completo (script + div)
- [ ] Guardo los cambios
- [ ] Verifico en http://localhost:8080 que aparece

---

**¿En qué posición exacta quieres el widget?**
- Al inicio (después del header)
- En medio
- Al final
- En una sección específica

Cuéntame y te diré exactamente dónde insertar el código.
