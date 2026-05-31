💡 Proyecto: Mi Primera Aplicación en Flutter - Generador de Ideas (Wordify)

📌 Descripción del proyecto
[cite_start]Este proyecto consiste en el desarrollo de una aplicación multiplataforma (ejecutada en entorno web) utilizando Flutter[cite: 306, 313]. [cite_start]La aplicación genera palabras aleatorias en inglés de forma dinámica, permitiendo al usuario visualizarlas en una interfaz limpia, marcarlas como favoritas y gestionarlas desde una sección dedicada mediante un menú de navegación interactivo[cite: 252].

📌 Objetivo del proyecto
[cite_start]Comprender el funcionamiento práctico de la creación de interfaces de usuario, el manejo del estado global y la navegación entre pantallas independientes utilizando el framework Flutter[cite: 251].

🧠 Problema que resuelve
[cite_start]Muchas aplicaciones iniciales de desarrollo móvil o web se limitan a interfaces estáticas o locales sin interactividad real[cite: 261]. [cite_start]Este proyecto soluciona ese problema al implementar una lógica reactiva donde las propuestas de palabras se generan en tiempo real y el estado de los "favoritos" se comparte y preserva entre pantallas de forma dinámica sin perder la información durante la navegación[cite: 252, 260].

🧰 Tecnologías utilizadas
* [cite_start]**Flutter**: Framework principal para el desarrollo de la interfaz gráfica y la estructura web de la aplicación[cite: 251, 313].
* [cite_start]**Dart**: Lenguaje de programación utilizado para toda la lógica de negocio y comportamiento de los widgets[cite: 263].
* [cite_start]**Visual Studio Code / Windows PowerShell**: Entorno de desarrollo integrado y terminal para la ejecución de comandos de Flutter[cite: 253, 305].
* [cite_start]**english_words (^4.0.0)**: Librería/paquete externo utilizado para proveer el diccionario y la generación de combinaciones aleatorias de palabras[cite: 256, 257].
* **provider (^6.0.0)**: Paquete encargado de la gestión de estados para compartir y actualizar los datos entre componentes de manera eficiente[cite: 256, 257].
* [cite_start]**Microsoft Edge**: Navegador web utilizado como dispositivo de prueba para compilar y validar la aplicación a través de Flutter Web[cite: 305, 306].

📚 Conceptos aplicados
* [cite_start]**ChangeNotifier & Provider**: Utilizados en la clase `MyAppState` para almacenar la palabra actual y la lista de favoritas, notificando automáticamente a la interfaz (`notifyListeners()`) ante cualquier cambio en los datos[cite: 266, 280].
* **StatefulWidget & Stateless`Widget**: Aplicados estratégicamente; [cite_start]`MyHomePage` se definió como un widget con estado para controlar el índice de navegación (`selectedIndex`) [cite: 282, 285][cite_start], mientras que pantallas atómicas como `GeneratorPage`, `BigCard` o `FavoritesPage` se implementaron como componentes sin estado dependientes del proveedor global[cite: 294, 300, 302].
* [cite_start]**Estructura Switch para Navegación**: Implementación de un bloque condicional `switch` para alternar dinámicamente el renderizado del widget central (`page`) basándose en la opción activa del menú lateral[cite: 287].
* [cite_start]**LayoutBuilder & Scaffold**: Utilizados para organizar de manera responsiva la estructura visual, permitiendo extender el menú lateral si las dimensiones de la pantalla aumentan[cite: 292, 293].
* **NavigationRail**: Widget interactivo empleado para construir un menú de navegación lateral moderno con accesos a 'Home' y 'Favorites'[cite: 292, 293].
* [cite_start]**ListView & ListTile**: Componentes estructurados para iterar y desplegar de forma limpia y ordenada la colección de palabras agregadas a favoritos[cite: 302, 304].
* [cite_start]**Personalización del Linter (analysis_options.yaml)**: Configuración flexible de reglas (`prefer_const_constructors: false` y `avoid_print: false`) optimizada para agilizar el flujo de aprendizaje inicial[cite: 261, 262].

🎮 Funcionalidades principales
* [cite_start]**Generador de ideas**: Creación ilimitada de palabras aleatorias al presionar el botón interactivo "Next"[cite: 299, 310].
* [cite_start]**Sistema de favoritos (Like)**: Opción de guardar o remover la palabra actual en una lista dinámica mediante un botón con cambio de icono adaptativo[cite: 298, 310].
* [cite_start]**Navegación fluida**: Menú lateral izquierdo completamente funcional para cambiar instantáneamente entre la pantalla del generador y el listado de favoritos[cite: 292, 310].
* [cite_start]**Visualización en Tarjeta Estilizada**: La palabra actual se presenta dentro del componente personalizado `BigCard`, aplicando el esquema de colores del tema (`Colors.deepOrange`) y tipografías aumentadas para una óptima legibilidad[cite: 276, 300, 301].
* [cite_start]**Validación de contenido**: Control visual inteligente en la sección de favoritos que muestra el mensaje *"No hay favoritos todavía."* cuando la lista se encuentra vacía[cite: 302, 303].

📸 Evidencias

Pantalla principal (GeneratorPage)
[Aquí puedes insertar la captura de la interfaz de inicio con la tarjeta central]

Generación de palabras
[Aquí puedes insertar la captura mostrando el cambio de palabras al pulsar Next]

Guardado de favoritos (Botón Like)
[Aquí puedes insertar la captura con el icono de corazón activo]

Apartado de tus favoritos (FavoritesPage)
[Aquí puedes insertar la captura de la lista con las palabras guardadas]

🚀 Instrucciones de ejecución

1. [cite_start]Descargar o clonar la carpeta del proyecto `generador_ideas` en tu equipo[cite: 253].
2. [cite_start]Abrir el directorio del proyecto desde la terminal o utilizando tu entorno de desarrollo (Visual Studio Code)[cite: 255, 256].
3. Validar el estado del entorno de Flutter ejecutando:
   ```bash
   flutter doctor
