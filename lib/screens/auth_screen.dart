import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventarios_unap/providers/auth_provider.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Autenticación')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(authRepositoryProvider).signInWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                    );
              },
              child: const Text('Iniciar Sesión'),
            ),
            TextButton(
              onPressed: () {
                ref.read(authRepositoryProvider).createUserWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                    );
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
