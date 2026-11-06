import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'models/producto.dart';

void main() {
  runApp(const CatalogoSenatiApp());
}

class CatalogoSenatiApp extends StatelessWidget {
  const CatalogoSenatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo SENATI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF003399)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final producto = settings.arguments as Producto;
          return MaterialPageRoute(
            builder: (_) => DetailScreen(producto: producto),
          );
        }
        return null;
      },
    );
  }
}
