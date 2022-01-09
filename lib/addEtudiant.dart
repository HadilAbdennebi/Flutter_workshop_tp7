import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'Student.dart';

class AddEtudiant extends StatefulWidget {
  const AddEtudiant({Key? key}) : super(key: key);

  @override
  _AddEtudiantState createState() => _AddEtudiantState();
}

class _AddEtudiantState extends State<AddEtudiant> {
  final _formKey = GlobalKey<FormState>();

  String? newValue;
  int? _Student;
  String? newValue1;
  Student student = Student("", "", "", "", "");
  String url = "http://172.30.48.1:8080/etudiants";

  Future save(Student) async {
    print(Student.nom);
    print(Student.prenom);
    print(Student.date_nais);
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nom': Student.nom,
          'prenom': Student.prenom,
          'dateNais': Student.date_nais,
          'classe_cod_class': '1',
          'formation_id': '1'
        }));
    print(res.body);
    if (res.body != null) {
      Navigator.pop(context);
    }
  }

  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController date_nais = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Adding student')),
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 570.0,
                            width: 340.0,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "Add Student",
                                      style: GoogleFonts.asset(fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                        controller: nom,
                                        decoration: InputDecoration(
                                          hintText: "Nom",
                                          border: OutlineInputBorder(),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                        controller: prenom,
                                        decoration: InputDecoration(
                                          hintText: "Prenom",
                                          border: OutlineInputBorder(),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                        controller: date_nais,
                                        decoration: InputDecoration(
                                          hintText: "Date Naissance",
                                          border: OutlineInputBorder(),
                                        )),
                                    ListView(
                                      padding: const EdgeInsets.all(8),
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          color: Colors.amber[600],
                                          child: const Center(
                                              child: Text('Element A')),
                                        ),
                                        Container(
                                          height: 50,
                                          color: Colors.amber[500],
                                          child: const Center(
                                              child: Text('Element B')),
                                        ),
                                        Container(
                                          height: 50,
                                          color: Colors.amber[100],
                                          child: const Center(
                                              child: Text('Element C')),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState == null) {}
                                          if (_formKey.currentState!
                                              .validate()) {
                                            save(Student(nom.text, prenom.text,
                                                date_nais.text, "", ""));
                                          }
                                        },
                                        child: Text("Add"))
                                  ],
                                )),
                          ),
                        ])))));
  }
}
