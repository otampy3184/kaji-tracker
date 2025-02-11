import 'package:flutter/material.dart';
import 'views/home_view.dart';
import 'views/login_view.dart'; // 先ほど作成したログイン画面

void main() {
  runApp(const MyApp());
}

/// アプリ全体のルートウィジェット
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '家事トラッカー',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeView(),
      },
    );
  }
}