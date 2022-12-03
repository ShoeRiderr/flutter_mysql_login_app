import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      LoginPage.tag: (context) => const LoginPage(),
      HomePage.tag: (context) => const HomePage(),
    };

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: routes,
    );
  }
}
