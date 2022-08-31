import 'package:flutter/material.dart';
import 'package:sarorcall/pages/Login.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  static const String Title = "Sign Up";
  final _loginkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
        ),
        body: Form(
          key: _loginkey,
          child: Center(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 150, bottom: 10),
              child: (ListView(
                scrollDirection: Axis.vertical,
                children: [
                  InputField("", "", "first name"),
                  InputField("", "", "last name"),
                  InputField("", "", "address"),
                  InputField("", "", "phone"),
                  InputField(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      "*email must be in the form example@domain.com",
                      "email"),
                  InputField(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      "*password must be at least 10 characters" +
                          '\n'
                              " with at least 1 uppercase, 1 lowercase and 1 special character ",
                      "password"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_loginkey.currentState!.validate()) {
                         
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        }
                      },
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  String regex;
  String error = "";
  String name = "";

  InputField(this.regex, this.error, this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: (TextFormField(
        decoration: InputDecoration(
          hintText: name,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "*" + name + " field can not be empty";
          } else if (!RegExp(regex).hasMatch(value)) {
            print("here");
            return error;
          }
          return null;
        },
        keyboardType: name == "email"? TextInputType.emailAddress: name == "phone"? TextInputType.phone : TextInputType.text,
      obscureText: name == "password"? true : false,

      )),
    );
  }
}
