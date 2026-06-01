# 💡 Proyecto_02 : Generador de Ideas en Flutter 

---

## 📌 Descripción del proyecto

Este proyecto consiste en el desarrollo de una aplicación multiplataforma (ejecutada en entorno web) utilizando Flutter.  La aplicación genera de manera dinámica combinaciones de palabras aleatorias en inglés, permitiendo al usuario visualizarlas a través de una interfaz moderna, marcarlas como favoritas y gestionarlas desde una sección dedicada mediante un menú de navegación interactivo.

---

## 📌 Objetivo del proyecto

Comprender el funcionamiento práctico de la creación de interfaces de usuario, el manejo del estado global y la navegación entre pantallas independientes utilizando el framework Flutter.

---

## 🧠 Problema que resuelve

Muchas aplicaciones de ejemplo iniciales se limitan a interfaces estáticas o locales sin interactividad real. Este proyecto resuelve ese problema al implementar una lógica reactiva donde las propuestas de palabras se generan en tiempo real y el estado de los "favoritos" se comparte y preserva entre pantallas de forma dinámica sin perder la información durante la navegación.

---

## 🧰 Tecnologías utilizadas

- Flutter: Framework principal para el desarrollo de la interfaz gráfica y la estructura web de la app
  
- Dart: Lenguaje de programación utilizado para toda la lógica de negocio y comportamiento de los widgets
  
- Visual Studio Code / Windows PowerShell: Entorno de desarrollo integrado y terminal para la ejecución de comandos de Flutter
  
- english_words: Librería/paquete externo utilizado para proveer el diccionario y la generación de combinaciones aleatorias
    
- provider: Paquete encargado de la gestión de estados para compartir y actualizar los datos entre componentes de manera eficiente
  
- Microsoft Edge: Navegador web utilizado como dispositivo de prueba para compilar y validar la aplicación a través de Flutter Web  

---

## 📚 Conceptos aplicados

- ChangeNotifier & Provider: Los utilicé en la clase `MyAppState` para almacenar la palabra actual y la lista de favoritas, notificando automáticamente a la interfaz ante cualquier cambio en los datos.
  
- StatefulWidget y StatelessWidget: Los apliqué estratégicamente; la pantalla principal se definió con estado para controlar el índice de navegación, mientras que componentes como las tarjetas de palabras se mantuvieron sin estado.
  
- Estructura Switch para Navegación: La utilicé para alternar dinámicamente el renderizado de la pantalla central basándose en la opción activa del menú lateral.
  
- LayoutBuilder & Scaffold: Los utilicé para organizar de manera responsiva la estructura visual, permitiendo extender o contraer el menú lateral según las dimensiones de la pantalla.
  
- NavigationRail: Lo utilicé para construir un menú de navegación lateral moderno con accesos directos a 'Home' y 'Favorites'.
  
- ListView y ListTile: Los utilicé para iterar y desplegar de forma limpia y ordenada la colección de palabras agregadas a favoritos.
  
- Personalización del Linter (analysis_options.yaml): Lo apliqué para flexibilizar las reglas de desarrollo iniciales, facilitando el aprendizaje continuo del flujo del framework.

---

## 🎮 Funcionalidades principales

- Generador ilimitado de combinaciones de palabras aleatorias en inglés  
- Sistema de favoritos (Like) con iconos dinámicos y adaptativos  
- Menú lateral interactivo para navegación fluida entre pantallas  
- Diseño responsivo que se adapta automáticamente al tamaño del navegador web  
- Visualización de palabras destacadas en tarjetas estilizadas (BigCard) usando los colores del tema  
- Validación automática de contenido con alertas visuales ("No hay favoritos todavía") si la lista se encuentra vacía  

---

## 📸 Evidencias

### Pantalla principal 
![Pantalla principal](Capturas/pantalla_inicio.png)

### Generación de palabras
![Generación de palabras](Capturas/palabras_generadas.png)

### Apartado de tus favoritos 
![Apartado de tus favoritos](Capturas/favoritos.png)

---

## 🚀 Instrucciones de ejecución

1. Descargar o clonar la carpeta del proyecto `generador_ideas` en tu computadora.

```bash
git clone <URL_DEL_REPOSITORIO>

```

3. Abrir la carpeta del proyecto en **Visual Studio Code**.  

4. Verificar que Flutter esté instalado correctamente ejecutando en la terminal:  

```bash
flutter doctor

```

4.  Instalar las dependencias ejecutando:

```bash
flutter pub get

```

5. Ejecutar la aplicación mediante:

```bash
flutter run
```

## Resultados Obtenidos

Se desarrolló un generador de ideas completamente funcional que permite crear y visualizar combinaciones de palabras aleatorias en inglés a través de una aplicación web. La interfaz muestra una tarjeta central estilizada con el término actual, botones interactivos para avanzar o marcar un "Like", y un menú de navegación lateral responsivo que se adapta al tamaño de la pantalla. 

## Reflexión Personal

### ¿Qué aprendí?

Aprendí a desarrollar una aplicación multiplataforma con Flutter, comprendiendo el uso de widgets, la navegación entre pantallas y la gestión de estados globales mediante Provider y MyAppState. También asimilé cómo integrar paquetes externos como english_words para la generación dinámica de palabras y cómo compilar y probar con éxito el proyecto en un entorno web utilizando Microsoft Edge.

### ¿Qué fue difícil?

Lo más complicado fue entender la jerarquía y el comportamiento responsivo de widgets como LayoutBuilder y NavigationRail para estructurar correctamente el menú lateral. Asimismo, al principio me costó trabajo coordinar el índice de navegación con la lógica de estados para asegurar que la interfaz reaccionara de inmediato al pulsar los botones usando notifyListeners().

### ¿Qué mejoraría?

Implementaría persistencia de datos local (con SharedPreferences o una base de datos) para que los favoritos no se borren al cerrar o recargar el navegador. También agregaría microanimaciones fluidas al cambiar de palabra en la tarjeta (BigCard), una función para copiar las ideas directamente al portapapeles y soporte para generar palabras en otros idiomas además del inglés.
