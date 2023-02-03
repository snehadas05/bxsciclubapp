import 'package:flutter/material.dart';
import '../colors.dart';
import 'homepage.dart';
import 'useraccount.dart';
import 'DB.dart';
import 'package:postgres/postgres.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  String email = '';
  String password = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext elements) {
    return Scaffold(
      backgroundColor: beaublue,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
            child: Center(
              child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/icon.jpeg')),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 50.0),
            child: TextField(
              obscureText: true,
              controller: passwordcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Password'),
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //     //TODO FORGOT PASSWORD SCREEN GOES HERE
          //   },
          //   child: Text(
          //     'Forgot Password',
          //     style: TextStyle(color: Colors.blue, fontSize: 15),
          //   ),
          // ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: xanadu, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () async {
                email = emailcontroller.text;
                password = passwordcontroller.text;
                bool a = await login(email, password);
                if (a == true) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomePage(useremail: email)));
                } else {
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
                          child: const Text('Invalid Login Credentials')),
                    ),
                  );
                }
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: 30,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => NewAccount()));
              },
              child: Text(
                'New User? Create Account',
                style: TextStyle(color: xanadu),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
