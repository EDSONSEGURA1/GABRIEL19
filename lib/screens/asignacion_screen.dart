import 'package:flutter/material.dart';

// Se eliminó la importación de app_theme.dart porque no se usaba directamente.

class AsignacionScreen extends StatefulWidget {
  const AsignacionScreen({super.key});

  @override
  State<AsignacionScreen> createState() => _AsignacionScreenState();
}

class _AsignacionScreenState extends State<AsignacionScreen> {
  String? _selectedAlumno;
  String? _selectedMateria;
  UniqueKey _alumnoKey = UniqueKey();
  UniqueKey _materiaKey = UniqueKey();

  final List<String> _alumnosMock = [
    'Alex García (AITEC-2024-001)',
    'María Rodríguez (AITEC-2024-002)',
    'Ana Martínez (AITEC-2024-004)',
    'Carlos Mendoza (AITEC-2024-005)',
  ];

  final List<String> _materiasMock = [
    'Programación Móvil (SW-401)',
    'Base de Datos Avanzadas (SW-302)',
    'Criptografía y Redes (CB-105)',
    'Conmutación y Enrutamiento (RD-210)',
  ];

  final List<Map<String, String>> _todasLasAsignaciones = [
    {
      'alumno': 'Alex García',
      'materia': 'Programación Móvil',
      'fecha': '20/05/2026',
    },
    {
      'alumno': 'María Rodríguez',
      'materia': 'Criptografía y Redes',
      'fecha': '19/05/2026',
    },
    {
      'alumno': 'Alex García',
      'materia': 'Base de Datos Avanzadas',
      'fecha': '20/05/2026',
    },
  ];

  late List<Map<String, String>> _asignacionesFiltradas;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _asignacionesFiltradas = List.from(_todasLasAsignaciones);
    _searchController.addListener(_filtrarAsignaciones);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filtrarAsignaciones);
    _searchController.dispose();
    super.dispose();
  }

  void _filtrarAsignaciones() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _asignacionesFiltradas = _todasLasAsignaciones.where((asignacion) {
        final nombreAlumno = asignacion['alumno']!.toLowerCase();
        final nombreMateria = asignacion['materia']!.toLowerCase();
        return nombreAlumno.contains(query) || nombreMateria.contains(query);
      }).toList();
    });
  }

  void _registrarAsignacion() {
    if (_selectedAlumno == null || _selectedMateria == null) return;

    final nombreLimpio = _selectedAlumno!.split(' (')[0];
    final materiaLimpia = _selectedMateria!.split(' (')[0];

    final nuevaAsignacion = {
      'alumno': nombreLimpio,
      'materia': materiaLimpia,
      'fecha': '21/05/2026', // Fecha simulada
    };

    setState(() {
      _todasLasAsignaciones.insert(0, nuevaAsignacion);
      _filtrarAsignaciones(); 
      _selectedAlumno = null;
      _selectedMateria = null;
      _alumnoKey = UniqueKey();
      _materiaKey = UniqueKey();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Asignación local registrada exitosamente'),
        backgroundColor: Colors.green.shade700,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeObject = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: themeObject.dividerColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                     Text(
                      'Vincular Alumno a Materia',
                      style: themeObject.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: themeObject.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownMenu<String>(
                      key: _alumnoKey,
                      width: MediaQuery.of(context).size.width - 64,
                      label: const Text('Seleccionar Alumno'),
                      leadingIcon: const Icon(Icons.person_outline_rounded),
                      onSelected: (String? value) {
                        setState(() => _selectedAlumno = value);
                      },
                      dropdownMenuEntries: _alumnosMock
                          .map((String value) =>
                              DropdownMenuEntry<String>(value: value, label: value))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    DropdownMenu<String>(
                      key: _materiaKey,
                      width: MediaQuery.of(context).size.width - 64,
                      label: const Text('Seleccionar Materia'),
                      leadingIcon: const Icon(Icons.book_outlined),
                      onSelected: (String? value) {
                        setState(() => _selectedMateria = value);
                      },
                      dropdownMenuEntries: _materiasMock
                          .map((String value) =>
                              DropdownMenuEntry<String>(value: value, label: value))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: (_selectedAlumno != null && _selectedMateria != null) 
                          ? _registrarAsignacion 
                          : null,
                      icon: const Icon(Icons.link_rounded),
                      label: const Text('ASIGNAR CURSO'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: themeObject.colorScheme.primary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por alumno o materia...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                 fillColor: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).colorScheme.surface
                    : Colors.grey[200],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Text(
              'Últimas Asignaciones',
              style: themeObject.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: _asignacionesFiltradas.isEmpty
            ? const Center(child: Text('No se encontraron asignaciones.'))
            : ListView.builder(
              itemCount: _asignacionesFiltradas.length,
              itemBuilder: (context, index) {
                final asignacion = _asignacionesFiltradas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      // CORRECCIÓN: Se reemplaza withOpacity por su sintaxis moderna
                      backgroundColor: themeObject.colorScheme.primary.withAlpha(25), // ~10% de opacidad
                      child: Icon(
                        Icons.assignment_ind_rounded,
                        color: themeObject.colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      asignacion['alumno']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Inscrito en: ${asignacion['materia']!}'),
                    trailing: Text(
                      asignacion['fecha']!,
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
