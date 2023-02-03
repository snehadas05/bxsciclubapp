import 'package:flutter/material.dart';
import 'main.dart';

import 'colors.dart';
import 'homepage.dart';
import 'db.dart';
import 'package:postgres/postgres.dart';
// List<String> clubs = <String>['Club 1', 'Club 2', 'Club 3', 'Club 4'];

class NewStudent extends StatefulWidget {
  NewStudent({Key? key}) : super(key: key);

  @override
  State<NewStudent> createState() => NewStudentState();
}

class NewStudentState extends State<NewStudent> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final osisController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final graduatingYearController = TextEditingController();

  Widget build(BuildContext elements) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: beaublue,
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Create Student Account',
              style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 8.0, right: 8.0, bottom: 20.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 8.0, right: 8.0, bottom: 20.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 8.0, right: 8.0, bottom: 20.0),
              child: TextField(
                controller: osisController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Osis',
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 8.0, right: 8.0, bottom: 20.0),
              child: TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 8.0, right: 8.0, bottom: 20.0),
              child: TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Last Name',
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 8.0, right: 8.0, bottom: 20.0),
              child: TextField(
                controller: graduatingYearController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Graduating Year',
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: xanadu, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;
                  String osis = osisController.text;
                  String fn = firstNameController.text;
                  String ln = lastNameController.text;
                  String gradyr = graduatingYearController.text;
                  bool a = await createNewStudentUser(
                      fn, ln, email, osis, password, gradyr);
                  if (a == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Container(
                            padding: const EdgeInsets.all(16),
                            height: 90,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(15, 211, 13, 66),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Text(
                                'account creation succesful! retun to login page and enter your email and password')),
                      ),
                    );
                  }

                  //connects to next page
                },
                child: Text(
                  'Create',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        )));
  }

  void addField(String _email, String _password, String _osis,
      String _firstname, String _lastname, String _gradYear) {
    emailController.clear();
    passwordController.clear();
    osisController.clear();
    firstNameController.clear();
    lastNameController.clear();
    graduatingYearController.clear();
  }
}
