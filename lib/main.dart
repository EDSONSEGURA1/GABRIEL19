import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controladores para capturar texto
    final TextEditingController userController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo Usuario
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            
            // Campo Contraseña
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),

            // Botón de login
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Acción del botón
                  String usuario = userController.text;
                  String password = passwordController.text;

                  // Solo muestra un mensaje (ejemplo)
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Datos ingresados'),
                      content: Text('Usuario: $usuario\nContraseña: $password'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}