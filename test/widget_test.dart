// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventarios_unap/screens/auth_screen.dart'; // Importa una pantalla real

void main() {
  testWidgets('AuthScreen has a title and buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Envolvemos el widget en un ProviderScope para que los providers funcionen.
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AuthScreen(),
        ),
      ),
    );

    // Verifica que el título de la AppBar esté presente.
    expect(find.text('Autenticación'), findsOneWidget);

    // Verifica que los botones de Iniciar Sesión y Registrarse existan.
    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('Registrarse'), findsOneWidget);

    // Ejemplo de interacción (no funcional sin un mock de AuthRepository):
    // await tester.tap(find.byType(ElevatedButton));
    // await tester.pump();
  });
}
