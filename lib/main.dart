import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/router/app_router.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/providers/club_provider.dart';
import 'package:myapp/providers/fichaje_provider.dart';
import 'package:myapp/providers/jugador_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ClubProvider()),
        // CORREGIDO: FichajeProvider no depende de AuthProvider, se usa un provider normal.
        ChangeNotifierProvider(create: (context) => FichajeProvider()),

        // CORREGIDO: JugadorProvider SÍ depende de AuthProvider, por lo que el Proxy es correcto aquí.
        ChangeNotifierProxyProvider<AuthProvider, JugadorProvider>(
          // Se crea una instancia inicial que es reemplazada inmediatamente por el update.
          create: (context) => JugadorProvider(Provider.of<AuthProvider>(context, listen: false)),
          update: (context, auth, previous) => JugadorProvider(auth),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          final appRouter = AppRouter(authProvider: auth);
          return MaterialApp.router(
            title: 'Gestor de Fútbol',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              scaffoldBackgroundColor: Colors.grey[200],
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardTheme: CardThemeData(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            routerConfig: appRouter.router,
          );
        },
      ),
    );
  }
}
