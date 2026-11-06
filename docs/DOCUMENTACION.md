# INFORME DE DESARROLLO DE SOFTWARE

**INSTITUCIÓN:** SENATI  
**CARRERA:** Tecnologías de la Información  
**CURSO:** Aplicaciones para Dispositivos Móviles  
**DOCENTE:** Jorge Luque Chambi  
**ALUMNO:** [Coloca aquí tu Nombre y Apellidos]  
**PROYECTO:** Catálogo de Componentes Tecnológicos SENATI  
**FECHA:** 6 de Noviembre de 2026  

---

## 1. INTRODUCCIÓN Y OBJETIVOS

El presente informe describe el diseño, arquitectura y desarrollo de la aplicación móvil **"Catálogo SENATI"**, desarrollada con el framework **Flutter** y lenguaje **Dart**. 

El propósito de la aplicación es brindar a estudiantes y docentes de laboratorios de TI una herramienta interactiva para:
- Visualizar un catálogo de componentes y periféricos de hardware en moneda nacional (S/.).
- Filtrar componentes por categorías y mediante un buscador en tiempo real.
- Registrar nuevos componentes de manera dinámica mediante una ventana modal.
- Consultar especificaciones y disponibilidad de stock en una ficha técnica detallada.

---

## 2. ESTRUCTURA MODULAR DEL PROYECTO

Para mantener el código ordenado y escalable, se aplicó una arquitectura modular dividiendo el proyecto en capas:

```
lib/
├── main.dart               # Configuración de tema y sistema de rutas (/home y /details)
├── models/
│   └── producto.dart       # Entidad Producto con sus propiedades y tipos de datos
└── screens/
    ├── home_screen.dart    # Vista principal: buscador, filtros, lista y modal de registro
    └── detail_screen.dart  # Ficha técnica con descripción extendida y precio destacado
```

---

## 3. EXPLICACIÓN DE PANTALLAS Y EVIDENCIAS

### 3.1. Pantalla Principal (Home / Catálogo)
Es la vista de inicio (`/home`). Cuenta con un encabezado institucional, un campo de búsqueda reactivo y una barra de botones tipo **FilterChip** horizontales para clasificar por: *Todos, Hardware, Procesadores, Almacenamiento y Periféricos*. La lista se actualiza automáticamente al escribir o seleccionar un filtro.

> 📷 **PEGAR AQUÍ CAPTURA 1:**  
> *(Captura de la pantalla principal mostrando la lista de componentes y los chips de categorías)*  
> ```
> +---------------------------------------------------------+
> |                                                         |
> |               [ PEGAR CAPTURA DEL HOME ]                |
> |                                                         |
> +---------------------------------------------------------+
> ```

---

### 3.2. Formulario de Registro (Modal Emergente)
Al presionar el botón flotante inferior **(+) Nuevo Componente**, se abre un diálogo modal (`AlertDialog`) con un formulario validado que contiene:
- Nombre del componente (Texto).
- Categoría (Menú desplegable `DropdownButtonFormField`).
- Precio referencial con formato numérico.
- Descripción técnica detallada.

Al dar clic en **"Guardar Componente"**, se valida que ningún campo esté vacío y se inserta el nuevo producto a la lista visible al instante.

> 📷 **PEGAR AQUÍ CAPTURA 2:**  
> *(Captura del formulario modal abierto con los campos para registrar un nuevo componente)*  
> ```
> +---------------------------------------------------------+
> |                                                         |
> |            [ PEGAR CAPTURA DEL FORMULARIO ]             |
> |                                                         |
> +---------------------------------------------------------+
> ```

---

### 3.3. Ficha Técnica (Detalle del Componente)
Al presionar cualquier producto de la lista, la aplicación navega a la ruta `/details` pasando la información seleccionada como argumento. Esta vista muestra:
- Icono e identificación de la categoría.
- Tarjeta con la descripción técnica completa.
- Recuadro verde destacado con el precio en soles y la etiqueta: *"Stock disponible en almacén"*.
- Botón para volver al catálogo limpiando la ruta anterior mediante `Navigator.pop()`.

> 📷 **PEGAR AQUÍ CAPTURA 3:**  
> *(Captura de la ficha técnica de un producto, por ejemplo los Parlantes o el Procesador)*  
> ```
> +---------------------------------------------------------+
> |                                                         |
> |            [ PEGAR CAPTURA DE FICHA TÉCNICA ]           |
> |                                                         |
> +---------------------------------------------------------+
> ```

---

### 3.4. Ejecución en Celular Físico (Compilación APK)
Para llevar la aplicación a un celular Android real:
1. Se configuró el entorno del SDK de Android mediante `flutter doctor`.
2. Se compiló el paquete nativo instalable con el comando:
   ```bash
   flutter build apk --debug
   ```
3. Se transfirió el archivo `.apk` al smartphone y se realizó la instalación exitosa.

> 📷 **PEGAR AQUÍ CAPTURA 4:**  
> *(Foto o captura de la aplicación funcionando instalada en tu teléfono celular)*  
> ```
> +---------------------------------------------------------+
> |                                                         |
> |           [ PEGAR CAPTURA DE LA APP EN EL CELULAR ]     |
> |                                                         |
> +---------------------------------------------------------+
> ```

---

## 4. WIDGETS Y HERRAMIENTAS UTILIZADAS

| Concepto | Componente en Flutter | Utilidad |
|---|---|---|
| **Estructura base** | `Scaffold`, `AppBar` | Maquetación visual siguiendo Material Design 3. |
| **Buscador interactivo** | `TextField`, `TextEditingController` | Filtrado instantáneo por texto en tiempo real. |
| **Categorías** | `FilterChip`, `ListView.builder` | Filtrado dinámico horizontal con selección visual. |
| **Lista de productos** | `Card`, `ListTile`, `CircleAvatar` | Presentación ordenada de los componentes con precio. |
| **Acción flotante** | `FloatingActionButton.extended` | Botón accesible para agregar nuevos productos. |
| **Formulario modal** | `AlertDialog`, `Form`, `GlobalKey` | Ventana emergente con validación de entradas. |
| **Navegación SPA** | `Navigator.pushNamed`, `Navigator.pop` | Flujo fluido entre la lista y la ficha técnica. |

---

## 5. CONCLUSIONES

1. **Modularidad y escalabilidad:** La separación del modelo de datos (`Producto`) y las vistas individuales facilita la lectura, mantenimiento y futuras ampliaciones de la app.
2. **Reactividad eficiente:** Gracias al uso de `setState()` y colecciones filtradas con `.where()`, la interfaz responde de manera inmediata sin recargar pantallas.
3. **Multiplataforma:** La misma base de código desarrollada se ejecuta tanto en entorno web para pruebas rápidas como en dispositivos móviles Android de forma nativa.

