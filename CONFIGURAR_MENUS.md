# 📋 Configurar Menús en WordPress + Astra

El menú "Main Menu" se importó correctamente en la BD, pero necesita estar **asignado a una ubicación visible** en el tema Astra.

---

## ✅ Solución Automática (Recomendado)

### En Windows:
```bash
reparar-menus.bat
```

### En Linux/Mac:
```bash
chmod +x reparar-menus.sh && docker-compose exec wordpress bash -c './reparar-menus.sh'
```

Este script automáticamente:
1. Encontrará el menú "Main Menu"
2. Lo asignará a la ubicación "Primary Menu" de Astra
3. Limpiará el caché

**Luego:**
1. Abre http://localhost:8080
2. Recarga la página (Ctrl+F5 o Cmd+Shift+R)
3. El menú debería aparecer en la parte superior

---

## 🔧 Solución Manual (Si lo anterior no funciona)

### Paso 1: Accede al Panel de WordPress

1. Ve a **http://localhost:8080/wp-admin**
2. Inicia sesión con tu usuario (admin / contraseña)

### Paso 2: Abre la Sección de Menús

1. Haz clic en **Apariencia** en el menú lateral izquierdo
2. Haz clic en **Menús**

Verás una pantalla como esta:

```
┌─────────────────────────────────────┐
│  Menús                              │
├─────────────────────────────────────┤
│  ☐ Main Menu                        │
│  ☐ Footer Menu (si existe)          │
│                                     │
│  ⊕ Crear nuevo menú                │
│  🔗 Gestionar ubicaciones           │
└─────────────────────────────────────┘
```

### Paso 3: Haz Clic en "Gestionar ubicaciones"

Verás algo así:

```
┌──────────────────────────────────────────┐
│  Gestionar ubicaciones                   │
├──────────────────────────────────────────┤
│  Primary Menu    ┌─────────────────────┐ │
│                  │ --- Selecciona ---   │ │
│                  │ Main Menu            │ │
│                  │ Footer Menu          │ │
│                  └─────────────────────┘ │
│                                          │
│  Mobile Menu     ┌─────────────────────┐ │
│                  │ --- Selecciona ---   │ │
│                  │ Main Menu            │ │
│                  │ Footer Menu          │ │
│                  └─────────────────────┘ │
│                                          │
│              [ Guardar cambios ]         │
└──────────────────────────────────────────┘
```

### Paso 4: Asigna los Menús

**Para cada ubicación:**

1. **Primary Menu**: Selecciona **Main Menu** del dropdown
2. **Mobile Menu**: Selecciona **Main Menu** del dropdown (opcional, depende del tema)

### Paso 5: Guarda los Cambios

1. Haz clic en el botón **Guardar cambios** (verde)
2. Verás un mensaje: "Se ha actualizado la ubicación del menú"

### Paso 6: Verifica en el Sitio

1. Abre en una nueva pestaña: **http://localhost:8080**
2. Recarga la página con **Ctrl+F5** (para limpiar caché)
3. El menú debería verse en la parte superior del sitio

---

## 🔍 Qué Ver en el Menú

Una vez configurado, en la página principal verás:

```
[ ENCALMA VACACIONAL ]
═══════════════════════════════════
📍 Inicio  Apartamentos  Sobre Nosotros  Contacto
═══════════════════════════════════
```

Si ves esto, ¡está funcionando! 🎉

---

## 🐛 Si Aún No Funciona

### Problema: El menú no aparece

**Posible causa 1: El tema Astra no está activado**
1. Ve a Apariencia → Temas
2. Verifica que Astra sea el tema "Activo" (aparece resaltado)
3. Si no, haz clic en "Activar"

**Posible causa 2: Los menús de Astra están en otra ubicación**
1. Ve a Apariencia → Personalizar
2. Busca la sección "Menú" o "Navegación"
3. Selecciona "Main Menu" aquí también

**Posible causa 3: Cache del navegador**
1. Presiona **Ctrl+Shift+Delete** para limpiar caché
2. O abre la página en una ventana privada/incógnito

### Problema: El menú aparece pero los items no se ven

**Solución:**
1. Ve a Apariencia → Menús → Main Menu
2. Verifica que haya items en el menú
3. Si está vacío, añade items:
   - Haz clic en **Añadir elementos**
   - Busca **Páginas**
   - Selecciona todas las páginas que quieras mostrar
   - Haz clic en **Añadir al menú**
4. Haz clic en **Guardar menú**

---

## 📝 Estructura del Menú Original

Según el XML importado, el menú contiene:

- **Inicio** (Home)
- **Apartamentos** (Products/Services)
- **Sobre Nosotros** (About)
- **Contacto** (Contact)
- **Política de Privacidad** (Privacy)
- **Aviso Legal** (Legal)

Si no ves todos estos items después de configurar, puede ser porque:

1. No todas las páginas se importaron correctamente
2. Los items del menú se perdieron en la importación

**Para reconstruir el menú manualmente:**

1. Ve a Apariencia → Menús → Main Menu
2. En la sección "Estructura del menú", haz clic en **Añadir elementos**
3. Busca cada página por su nombre
4. Selecciona y añade al menú
5. Organiza el orden arrastrando
6. Guarda

---

## ⚙️ Variables de Ubicación en Astra

El tema Astra típicamente usa estas ubicaciones de menú:

| Ubicación | Uso |
|-----------|-----|
| `primary-menu` | Menú principal en el header |
| `mobile-menu` | Menú para dispositivos móviles |
| `footer-menu` | Menú en el pie de página |
| `aside-menu` | Menú lateral (si existe) |

Si una ubicación no aparece, es porque Astra no la tiene configurada.

---

## 🎯 Checklist

- [ ] Astra está instalado y activado
- [ ] Elementor está instalado y activado
- [ ] El menú "Main Menu" existe en Apariencia → Menús
- [ ] El menú está asignado a "Primary Menu" en Gestionar ubicaciones
- [ ] La página principal muestra el menú en la parte superior
- [ ] Todos los items del menú son clickeables
- [ ] Los links llevan a las páginas correctas

---

**Nota:** Si después de hacer todo esto aún no ves el menú, revisa la consola del navegador (F12) para ver si hay errores de JavaScript que lo estén ocultando.
