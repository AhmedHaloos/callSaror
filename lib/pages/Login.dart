import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sarorcall/main.dart';
import 'package:sarorcall/pages/Register.dart';
import 'package:http/http.dart' as http ;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          (Form(
            key: _loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "email",
                  ),
                  textAlign: TextAlign.start,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*email field can not be empty";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "*email must be in the form example@domain.com";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*password field can not be empty";
                    } else if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                        .hasMatch(value)) {
                      return "*password must be at least 10 characters" +
                          '\n'
                              " with at least 1 uppercase, 1 lowercase and 1 special character ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "passwod",
                  ),
                  obscureText: true,

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async{

                     if (_loginKey.currentState!.validate()) {
                       Navigator.pushReplacement(context,
                           MaterialPageRoute(builder: (context) => Home(0)));
                     }
                    },
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
              child: Text("Regidter"))
        ]),
      ),
    );
  }
}
