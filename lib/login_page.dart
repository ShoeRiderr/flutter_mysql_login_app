import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String tag = 'login-page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future login(BuildContext context) async {
    String name = nameController.text;
    String password = passwordController.text;

    if (name == "" || password == "") {
      Fluttertoast.showToast(
          msg: "Name and password have to be filled",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    String? domain = dotenv.env["AUTH_API"];
    String url = "$domain/login_connection/login.php";

    Response response = await post(url, body: {
      "name": name,
      "password": password
    });

    var data = json.decode(response.body);

    if (data.status) {
      Fluttertoast.showToast(
          msg: "Welcome!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.of(context).pushNamed(HomePage.tag);
    } else {
      Fluttertoast.showToast(
          msg: "Username or password is not correct.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final name = TextFormField(
      controller: nameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'User name',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      )
    );

    final password = TextFormField(
        controller: passwordController,
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0)
            )
        )
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        shadowColor: Colors.lightBlueAccent.shade100,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            login(context);
          },
          color: Colors.lightBlueAccent,
          child: const Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = TextButton(
      onPressed: () {  },
      child: const Text(
        'Forget password?',
        style: TextStyle(color: Colors.black54),
      )
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            name,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        )
      )
    );
  }
}
