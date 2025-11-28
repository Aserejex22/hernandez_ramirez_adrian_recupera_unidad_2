# Guía de Plantas - Flutter App

Aplicación Flutter que muestra información sobre plantas utilizando el patrón MVVM con Provider.

## Estructura del Proyecto

```
lib/
├── models/
│   └── plant.dart                 # Modelo de datos Plant
├── viewmodels/
│   ├── plant_viewmodel.dart       # ViewModel para gestión de plantas
│   └── theme_viewmodel.dart       # ViewModel para gestión de temas
├── views/
│   ├── plant_list_screen.dart     # Pantalla principal con lista de plantas
│   └── plant_detail_screen.dart   # Pantalla de detalle de planta
└── main.dart                       # Punto de entrada con Provider

assets/
└── plants.json                     # Archivo JSON con datos de plantas
```

## Características Implementadas

### ✅ Patrón MVVM
- **Model**: `Plant` - Modelo de datos con serialización JSON
- **View**: `PlantListScreen`, `PlantDetailScreen` - Vistas de UI
- **ViewModel**: `PlantViewModel`, `ThemeViewModel` - Lógica de negocio

### ✅ Gestión de Estado con Provider
- `PlantViewModel`: Gestiona carga y estado de plantas
- `ThemeViewModel`: Gestiona cambio entre temas claro/oscuro

### ✅ StatefulWidget
- `PlantListScreen` implementa StatefulWidget con ciclo de vida completo
- Carga de datos en `initState()`

### ✅ Temas Personalizados
- Tema claro con colores basados en verde
- Tema oscuro con colores basados en verde
- Switch/botón en AppBar para cambiar entre temas

### ✅ Navegación
- Navegación de lista a detalle de planta
- Hero animation en imágenes

### ✅ Manejo de Errores
- Mensajes de error amigables al usuario
- Botón de reintentar en caso de fallo
- Placeholders para imágenes que no cargan

## Formato del JSON

El archivo `assets/plants.json` debe tener el siguiente formato:

```json
[
  {
    "nombre": "Nombre común de la planta",
    "nombreCientifico": "Nombre científico",
    "descripcion": "Descripción de la planta",
    "imagen": "URL de la imagen",
    "cuidados": "Instrucciones de cuidado"
  }
]
```

## Cómo Ejecutar

1. Instalar dependencias:
```bash
flutter pub get
```

2. Ejecutar la aplicación:
```bash
flutter run
```

## Dependencias

- `flutter`: SDK de Flutter
- `provider: ^6.1.1`: Gestión de estado

## Funcionalidades

1. **Listado de Plantas**: Muestra tarjetas con imagen y nombre de cada planta
2. **Detalle de Planta**: Vista completa con toda la información
3. **Cambio de Tema**: Botón en AppBar para alternar entre claro/oscuro
4. **Carga de Datos**: Lee plantas desde archivo JSON local
5. **Manejo de Errores**: Feedback visual cuando falla la carga
