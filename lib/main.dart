import 'package:flutter/material.dart';
import 'homepage.dart';
import 'login.dart';
import 'colors.dart';
import 'package:postgres/postgres.dart';
import 'db.dart';

void main() {
  runApp(MyApp());
  Future<bool> a = login('dass3@bxscience.edu', 'password');
  print(a);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}




// class UserAcc {
//   String name, email, pass, gradyr, osis;
//   UserAcc(this.name, this.email, this.pass, this.gradyr, this.osis);
// }
