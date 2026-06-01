import 'dart:io';
import 'dart:convert';

// Clase Registro
class Registro {
  String nombre;
  int edad;
  double salario;

  Registro({
    required this.nombre,
    required this.edad,
    required this.salario,
  });

  // Convertir de JSON a objeto
  factory Registro.fromJson(Map<String, dynamic> json) {
    return Registro(
      nombre: json['nombre'] ?? '',
      edad: json['edad'] ?? 0,
      salario: (json['salario'] ?? 0).toDouble(),
    );
  }

  // Convertir objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'edad': edad,
      'salario': salario,
    };
  }
}

// Lista global
List<Registro> registros = [];


// Cargar JSON
void cargarDatos() {
  final file = File('datos.json');
  final contenido = file.readAsStringSync();
  final data = jsonDecode(contenido);

  registros = data.map<Registro>((e) => Registro.fromJson(e)).toList();

  print("Datos cargados correctamente\n");
}

// Mostrar datos
void mostrarDatos() {
  for (var r in registros) {
    print("${r.nombre} - Edad: ${r.edad} - Salario: ${r.salario}");
  }
}

// Buscar por nombre
void buscarPorNombre() {
  print("Ingresa nombre:");
  String? nombre = stdin.readLineSync();

  var resultado = registros.where((r) => r.nombre == nombre);

  for (var r in resultado) {
    print("${r.nombre} - ${r.edad} - ${r.salario}");
  }
}

// Filtrar por edad
void filtrarPorEdad() {
  print("Edad mínima:");
  int edad = int.parse(stdin.readLineSync()!);

  var resultado = registros.where((r) => r.edad >= edad);

  for (var r in resultado) {
    print("${r.nombre} - ${r.edad}");
  }
}

// Estadísticas
void estadisticas() {
  if (registros.isEmpty) return;

  double promedioSalario =
      registros.map((r) => r.salario).reduce((a, b) => a + b) /
          registros.length;

  int edadMin = registros.map((r) => r.edad).reduce((a, b) => a < b ? a : b);
  int edadMax = registros.map((r) => r.edad).reduce((a, b) => a > b ? a : b);

  print("\n--- Estadísticas ---");
  print("Promedio salario: $promedioSalario");
  print("Edad mínima: $edadMin");
  print("Edad máxima: $edadMax");
  print("Total registros: ${registros.length}");
}

// Exportar JSON
void exportarResumen() {
  final file = File('resumen.json');

  var resumen = registros.map((r) => r.toJson()).toList();

  file.writeAsStringSync(jsonEncode(resumen));

  print("Resumen exportado\n");
}

// Menú
void menu() {
  while (true) {
    print("\n--- MENÚ ---");
    print("1. Cargar datos");
    print("2. Mostrar datos");
    print("3. Buscar por nombre");
    print("4. Filtrar por edad");
    print("5. Ver estadísticas");
    print("6. Exportar JSON");
    print("0. Salir");

print("Ingresa el número de la opción que deseas:");
String? opcion = stdin.readLineSync();

    switch (opcion) {
      case '1': cargarDatos(); break;
      case '2': mostrarDatos(); break;
      case '3': buscarPorNombre(); break;
      case '4': filtrarPorEdad(); break;
      case '5': estadisticas(); break;
      case '6': exportarResumen(); break;
      case '0': return;
      default:  print("Opción inválida");
    }
  }
}
void main() {
  menu();
}