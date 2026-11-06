# 💻 Catálogo SENATI - Flutter App

Aplicación móvil y web multiplataforma desarrollada en **Flutter** y **Dart** para la gestión y consulta visual del catálogo de componentes tecnológicos, hardware y periféricos informáticos de los laboratorios de **SENATI**.

---

## 🚀 Características Principales

- 🔐 **Pantalla de Inicio de Sesión (Login)** con el logo oficial de SENATI y validación de credenciales institucionales.
- 🏷️ **Filtros Dinámicos por Categorías** mediante `FilterChip` interactivos (*Todos, Hardware, Procesadores, Almacenamiento, Periféricos*).
- 🔍 **Buscador Reactivo en Tiempo Real** con coincidencia por nombre, categoría y especificación técnica.
- 📋 **Lista Dinámica de Productos** maquetada con `Card` y `ListTile` en Material Design 3 con precios formateados en moneda nacional (`S/.`).
- ➕ **Formulario de Registro Modal (`AlertDialog`)** para agregar nuevos componentes con validación de entradas.
- 📄 **Ficha Técnica Detallada (`/details`)** con paso de argumentos, descripción completa, contenedor de precio destacado y estado de stock en almacén.
- 🚪 **Cierre de Sesión (Logout)** rápido desde el AppBar del catálogo.

---

## 📂 Estructura Modular del Proyecto

```text
lib/
├── main.dart               # Rutas (/login, /home, /details) y tema institucional
├── models/
│   └── producto.dart       # Modelo de datos Producto
└── screens/
    ├── login_screen.dart   # Pantalla de inicio de sesión con logo SENATI
    ├── home_screen.dart    # Vista principal (buscador, chips, lista y modal)
    └── detail_screen.dart  # Ficha técnica detallada del componente
```

---

## 🛠️ Tecnologías Utilizadas

- **Framework:** Flutter 3 (Canal Stable)
- **Lenguaje:** Dart 3
- **Diseño:** Material Design 3
- **Plataformas:** Android & Web

---

## ▶️ Ejecución del Proyecto

### Requisitos Previos
Tener instalado el SDK de Flutter y configurado con `flutter doctor`.

### 1. Clonar el repositorio
```bash
git clone https://github.com/AngelOrdaya-Dev/Catalogo-Senati.git
cd Catalogo-Senati
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Ejecutar en Navegador Web
```bash
flutter run -d chrome
```

### 4. Ejecutar o Compilar para Android
```bash
# Probar en celular conectado por USB
flutter run

# Generar instalador APK
flutter build apk --debug
```

---

## 👨‍💻 Autor

Desarrollado para el curso de **Aplicaciones para Dispositivos Móviles** en **SENATI**.
