import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'Dashboard.dart';
import 'User.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "http://172.30.48.1:8080/login";

  Future save() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
    print(res.body);
    if (res.body != null) {
      String ch = res.body.toString();
      print(ch.length);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Start"),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 520.0,
                            width: 340.0,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    "Login",
                                    style: GoogleFonts.oswald(fontSize: 30),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller:
                                        TextEditingController(text: user.email),
                                    decoration: InputDecoration(
                                      hintText: "Your email...",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    controller: TextEditingController(
                                        text: user.password),
                                    decoration: InputDecoration(
                                      hintText: "Your password...",
                                      border: OutlineInputBorder(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState == null) return;
                                if (_formKey.currentState!.validate()) {
                                  save();
                                } else {
                                  action:
                                  SnackBarAction(
                                    label: "Not Valid!",
                                    textColor: Colors.white,
                                    onPressed: () {},
                                  );
                                }
                              },
                              child: Icon(Icons.arrow_forward),
                            ),
                          )
                        ])))));
  }
}
