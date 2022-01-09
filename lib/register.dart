import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tp7/Dashboard.dart';

import 'Dashboard2.dart';
import 'User.dart';
import 'addEtudiant.dart';
import 'login.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "http://172.30.48.1:8080/register";

  Future save() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
    print(res.body);
    if (res.body != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          actions: [
            TextButton.icon(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
              },
              label: const Text(
                "login",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.login,
                color: Colors.white,
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEtudiant(),
                    ));
              },
              label: const Text(
                "add",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(),
                    ));
              },
              label: const Text(
                "list",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.list,
                color: Colors.white,
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard2(),
                    ));
              },
              label: const Text(
                "classe",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.list,
                color: Colors.white,
              ),
            ),
          ],
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
                                    "Register",
                                    style: GoogleFonts.oswald(fontSize: 30),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller:
                                        TextEditingController(text: user.email),
                                    onChanged: (val) {
                                      user.email = val;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'email is Empty';
                                      }
                                      return null;
                                    },
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
                                    onChanged: (val) {
                                      user.password = val;
                                    },
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
                                }
                              },
                              child: Icon(Icons.arrow_forward),
                            ),
                          )
                        ])))));
  }
}
