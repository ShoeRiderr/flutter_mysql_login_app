import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      LoginPage.tag: (context) => const LoginPage(),
      HomePage.tag: (context) => const HomePage(),
    };

    return MaterialApp(
      title: 'Login MySQL App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: routes,
    );
  }
}
