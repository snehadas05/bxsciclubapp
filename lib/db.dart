import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'main.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter/material.dart';

Future<List<Student_User>> getAllStudents(PostgreSQLConnection conn) async {
  List<Student_User> allUsers = [];
  var results = await conn.query('SELECT * from student_users');
  conn.close();
  print(results);
  for (var row in results) {
    allUsers.add(Student_User(row[0], row[1], row[2], row[3], row[4], row[5]));
    print(allUsers);
  }
  return allUsers;
}

Future<List<Users>> getAllTeachers(PostgreSQLConnection conn) async {
  List<Users> allUsers = [];

  var results = await conn.query('SELECT * from student_users');
  conn.close();
  print(results);
  for (var row in results) {
    allUsers.add(Users(row[0], row[1], row[2], row[3]));
    print(allUsers);
  }
  return allUsers;
}

Future<List<String>> getAllClubs() async {
  List<String> allClubs = [];
  PostgreSQLConnection? connection = await getConnection();
  var results = await connection!.query('SELECT Club_Name from mytable');

  for (var row in results) {
    allClubs.add(row[0]);
  }
  connection.close();
  return allClubs;
}

Future<bool> login(email, secret) async {
  var accs = <String>[];
  try {
    PostgreSQLConnection? connection = await getConnection();

    var results = await connection
        ?.query("SELECT secret from student_users where email = '$email'");
    for (var row in results!) {
      accs.add(row[0]);
    }
    var results2 = await connection
        ?.query("SELECT secret from teacher_users where email = '$email'");
    for (var row in results2!) {
      accs.add(row[0]);
    }

    print(accs);
    if (accs.contains(secret)) {
      print('login true');
      return true;
    }
    print('login false');
    connection?.close();
    return false;
  } on SocketException catch (_) {
    return false;
  }
}

Future<PostgreSQLConnection?> getConnection() async {
  print('before connection');
  try {
    final connection = await PostgreSQLConnection(
      'localhost',
      5432,
      'postgres',
      username: 'snehadas',
      password: '',
    );
    await connection.open();
    print("Database Connected!");
    // await connection.open();
    // print('connected to db');
    return await connection;
  } on SocketException catch (e) {
    print(e);
    return null;
  }
}

Future<bool> createNewStudentUser(String First_Name, String Last_Name,
    String email, String osis, String secret, String grad_year) async {
  PostgreSQLConnection? connection = await getConnection();
  PostgreSQLResult? count = await connection
      ?.query("SELECT COUNT(*) FROM student_users WHERE email = '$email'");
  print('$First_Name $Last_Name $email $osis $secret $grad_year');
  if (count != 0) {
    await connection?.query('''
      INSERT INTO student_users (First_Name, Last_Name, email, osis, secret, grad_year)
      VALUES ('$First_Name', '$Last_Name', '$email', '$osis', '$secret', '$grad_year')
    ''');
    connection?.close();
    return true;
  }
  return false;
}

Future<bool> createNewTeacherUser(First_Name, Last_Name, email, secret) async {
  PostgreSQLConnection? connection = await getConnection();
  PostgreSQLResult? count = await connection
      ?.query("SELECT COUNT(*) FROM teacher_users WHERE email = '$email'");
  if (count != 0) {
    await connection?.query('''
      INSERT INTO teacher_users (First_Name, Last_Name, email, secret)
      VALUES ('$First_Name', '$Last_Name', '$email', '$secret')
    ''');
    connection?.close();
    return true;
  }
  return false;
}

class Users {
  String First_Name, Last_Name, email, secret;
  List<String> allEmails = [];
  Users(this.First_Name, this.Last_Name, this.email, this.secret);
}

class Student_User extends Users {
  Student_User(String First_Name, String Last_Name, String email, String osis,
      String secret, String grad_year)
      : super(First_Name, Last_Name, email, osis);
}

class Club {
  Future<List<String>> allClubs = getAllClubs();
  String Club_Name = ' ';
  String Days = ' ';
  String Room = ' ';
  String Presidents_First_Name = ' ';
  String Presidents_Bronx_Science_Email = ' ';
  String Presidents_Last_Name = ' ';
  Club(
    this.Club_Name,
    this.Days,
    this.Room,
    this.Presidents_First_Name,
    this.Presidents_Last_Name,
    this.Presidents_Bronx_Science_Email,
  );
}

Future<String> getName(int indx) async {
  List<String> allClubs = await getAllClubs();
  return allClubs.elementAt(indx);
}

Future<String> getPres(String club) async {
  var accs = <String>[];
  String presname = 'Presidents name: ';
  PostgreSQLConnection? connection = await getConnection();
  var fn = await connection!.query(
      "SELECT Presidents_First_Name FROM mytable WHERE Club_Name ='$club'");
  for (var row in fn) {
    accs.add(row[0]);
  }
  var ln = await connection.query(
      "SELECT Presidents_Last_Name FROM mytable WHERE Club_Name ='$club'");
  for (var row in ln) {
    accs.add(row[0]);
  }
  var email = await connection.query(
      "SELECT Presidents_Bronx_Science_Email FROM mytable WHERE Club_Name ='$club'");

  for (var row in email) {
    accs.add(row[0]);
  }
  connection.close();
  presname = 'Presidents name:' +
      accs.elementAt(0) +
      ' ' +
      accs.elementAt(1) +
      "   |   President's email: " +
      accs.elementAt(2);
  return presname;
}

Future<String> meetingInfo(String club) async {
  String info = 'Meeting day: ';
  PostgreSQLConnection? connection = await getConnection();
  var day = await connection!
      .query("SELECT days FROM mytable WHERE Club_Name ='$club'");
  for (var row in day) {
    info = info + row[0];
  }
  var room = await connection
      .query("SELECT Room FROM mytable WHERE Club_Name ='$club'");

  for (var row in room) {
    info = info + "   |   Meeting location: " + row[0];
  }
  connection.close();
  print(info);
  return info;
}

Future<bool> joinClub(String user, String club) async {
  PostgreSQLConnection? connection = await getConnection();
  List user = [];
  var joined = await connection!.query(
      "SELECT email FROM subscriptions WHERE email = 'email' AND Club_name = '$club'");
  for (var row in joined) {
    user.add(row[0]);
  }
  if (user.contains(user) == false) {
    await connection.query(
        "INSERT INTO subscriptions(email, Club_Name, Club_Position) VALUES( '$user', '$club', 'member')");
    connection.close();
    return true;
  }
  return false;
}
