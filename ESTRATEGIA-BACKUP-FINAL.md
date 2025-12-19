# Estrategia de Backup Final - En Calma Vacacional

## 🎯 Enfoque Simplificado

**Git:** Solo código y configuración
**UpdraftPlus:** Todo lo demás (BD, plugins, temas, imágenes, etc.)

---

## ✅ Qué va en Git

```
En_Calma_Vacacional/
├── docker-compose.yml              # Configuración Docker
├── php.ini                          # Configuración PHP
├── .env.example                     # Template (sin credenciales)
├── .gitignore                       # Archivos a ignorar
├── scripts/                         # Scripts útiles
├── plugins-custom/                  # Si tienes plugins custom
├── themes-custom/                   # Si tienes temas custom
└── sql-exports/estructura-db.sql   # Estructura BD (referencia)
```

## 📦 Qué Respaldar con UpdraftPlus

UpdraftPlus guarda automáticamente:
- ✅ Base de datos completa
- ✅ Plugins (custom + terceros)
- ✅ Temas (custom + terceros)
- ✅ Imágenes y uploads
- ✅ wp-config.php
- ✅ Toda la configuración

Y lo guarda en:
- Google Drive
- Dropbox
- AWS S3
- OneDrive
- Tu servidor

---

## 🚀 Setup Rápido

### 1. Instalar UpdraftPlus en WordPress

```bash
docker exec encalma_wordpress wp plugin install updraftplus --activate
```

### 2. Configurar en WordPress

1. Ve a `http://localhost:8080/wp-admin`
2. Menú: **Ajustes → UpdraftPlus**
3. Configura almacenamiento (Google Drive, Dropbox, etc.)
4. **"Hacer backup ahora"**

### 3. Versionar en Git

```bash
git add docker-compose.yml .env.example .gitignore scripts/ plugins-custom/ themes-custom/
git commit -m "feat: configurar backup con UpdraftPlus"
git push origin main
```

---

## 📋 Workflow Día a Día

```
DESARROLLO
├── Editar plugins/temas en WordPress
├── Probar cambios localmente
└── ✅ UpdraftPlus hace backup automático

CUANDO TERMINES CAMBIOS IMPORTANTES
├── UpdraftPlus: "Hacer backup ahora"
├── (Opcional) git commit si hay código custom
└── Backup guardado en Google Drive

RESTAURAR EN OTRA MÁQUINA
├── git clone
├── docker-compose up -d
├── Instalar UpdraftPlus
├── Descargar backup desde Google Drive
├── UpdraftPlus: "Restaurar"
└── ¡Listo!
```

---

## 💡 Ventajas

✅ **Simple** - No hay que gestionar archivos SQL manuales
✅ **Completo** - Respalda absolutamente todo
✅ **Automático** - Backups programados
✅ **Seguro** - Encriptado en Google Drive / S3 / etc
✅ **Fácil de restaurar** - Un clic en WordPress
✅ **Git limpio** - Solo código, no datos

---

## 🔒 Seguridad

- UpdraftPlus solo almacena en servicios como Google Drive (no Git)
- Credenciales nunca en Git (usa .env.example)
- BD completa en backup externo, no en repo

---

## Resumen

| Tarea | Herramienta |
|-------|-----------|
| Código custom | Git |
| BD + plugins + imágenes | UpdraftPlus |
| Sincronización entre máquinas | Git + UpdraftPlus |
| Recuperación ante desastre | UpdraftPlus |

**Simple, seguro, efectivo.** 🎉
