import 'package:flutter/material.dart';

class JugadoresScreen extends StatelessWidget {
  const JugadoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jugadores'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Sección en Construcción',
              style: TextStyle(fontSize: 22, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
