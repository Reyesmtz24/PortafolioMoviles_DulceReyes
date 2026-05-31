// Importo la librería que genera palabras aleatorias
import 'package:english_words/english_words.dart';

// Importo los componentes visuales de Flutter
import 'package:flutter/material.dart';

// Importo Provider para compartir datos entre pantallas
import 'package:provider/provider.dart';

void main() {
  // Inicio la aplicación
  runApp(MyApp());
}

// Clase principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Aquí creo el estado global de la aplicación
      create: (context) => MyAppState(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        // Nombre de la aplicación
        title: 'Wordify',

        // Configuración del tema principal
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
          ),
        ),

        // Pantalla principal
        home: MyHomePage(),
      ),
    );
  }
}

// Esta clase guarda los datos que se utilizarán en toda la aplicación
class MyAppState extends ChangeNotifier {
  
  // Genero un par de palabras aleatorio al iniciar
  var current = WordPair.random();

  // Lista donde guardaré las palabras favoritas
  var favorites = <WordPair>[];

  // Genera una nueva combinación de palabras
  void getNext() {
    current = WordPair.random();

    // Notifico a la interfaz que hubo cambios
    notifyListeners();
  }

  // Agrega o elimina palabras de favoritos
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }

    // Actualizo la interfaz
    notifyListeners();
  }
}

// Pantalla principal que controla la navegación
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Variable que indica qué pantalla está seleccionada
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget page;

    // Dependiendo de la opción seleccionada muestro una pantalla diferente
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;

      case 1:
        page = FavoritesPage();
        break;

      default:
        throw UnimplementedError(
          'No widget for $selectedIndex',
        );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [

              // Menú lateral de navegación
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,

                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),

                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],

                  selectedIndex: selectedIndex,

                  // Cambio de pantalla al seleccionar una opción
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),

              // Área principal donde se muestran las pantallas
              Expanded(
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Pantalla donde se generan las palabras aleatorias
class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Obtengo los datos compartidos de la aplicación
    var appState = context.watch<MyAppState>();

    // Obtengo el par de palabras actual
    var pair = appState.current;

    IconData icon;

    // Cambio el icono dependiendo si está en favoritos o no
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          // Tarjeta donde se muestran las palabras
          BigCard(pair: pair),

          SizedBox(height: 10),

          Row(
            mainAxisSize: MainAxisSize.min,

            children: [

              // Botón para agregar o quitar favoritos
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },

                icon: Icon(icon),

                label: Text('Like'),
              ),

              SizedBox(width: 10),

              // Botón para generar nuevas palabras
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },

                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Tarjeta personalizada donde se muestran las palabras generadas
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {

    // Obtengo el tema actual
    final theme = Theme.of(context);

    // Personalizo el estilo del texto
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,

      elevation: 8,

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Text(
          pair.asLowerCase,

          // Permite que lectores de pantalla lean las palabras separadas
          semanticsLabel:
              "${pair.first} ${pair.second}",

          style: style,
        ),
      ),
    );
  }
}

// Pantalla donde se muestran las palabras favoritas
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Obtengo la lista de favoritos
    var appState = context.watch<MyAppState>();

    // Si no hay favoritos muestro un mensaje
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text(
          'No hay favoritos todavía.',
        ),
      );
    }

    // Si existen favoritos los muestro en una lista
    return ListView(
      children: [

        Padding(
          padding: const EdgeInsets.all(20),

          child: Text(
            'Tus favoritos:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Recorro todos los favoritos y los muestro en pantalla
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),

            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}