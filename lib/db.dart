import 'dart:io';
import 'dart:convert';
import 'main.dart';
import 'package:postgres/postgres.dart';

class DB {
  Future<List<Student_User>> getAllStudents(PostgreSQLConnection conn) async {
    List<Student_User> allUsers = [];
    var results = await conn.query('SELECT * from student_users');
    print(results);
    for (var row in results) {
      allUsers
          .add(Student_User(row[0], row[1], row[2], row[3], row[4], row[5]));
      print(allUsers);
    }
    return allUsers;
  }

  Future<List<Users>> getAllTeachers(PostgreSQLConnection conn) async {
    List<Users> allUsers = [];

    var results = await conn.query('SELECT * from student_users');
    print(results);
    for (var row in results) {
      allUsers.add(Users(row[0], row[1], row[2], row[3]));
      print(allUsers);
    }
    return allUsers;
  }

  Future<List<Club>> getAllClubs(PostgreSQLConnection conn) async {
    List<Club> allClubs = [];

    var results = await conn.query('SELECT * from student_users');
    print(results);
    for (var row in results) {
      allClubs.add(Club(row[2], row[3], row[4], row[5], row[6], row[7], row[8],
          row[9], row[10], row[11], row[12], row[13], row[14], row[15]));
    }
    return allClubs;
  }
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
    connection?.close();
    print(accs);
    if (accs.contains(secret)) {
      print('login true');
      return true;
    }
    print('login false');
    return false;
  } on SocketException catch (_) {
    print('connection falied');
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

Future<void> createNewStudentUser(String First_Name, String Last_Name,
    String email, String osis, String secret, String grad_year) async {
  PostgreSQLConnection? connection = await getConnection();
  print('$First_Name $Last_Name $email $osis $secret $grad_year');
  await connection?.query('''
      INSERT INTO student_users (First_Name, Last_Name, email, osis, secret, grad_year)
      VALUES ('$First_Name', '$Last_Name', '$email', '$osis', '$secret', '$grad_year')
    ''');
}

Future<void> createNewTeacherUser(First_Name, Last_Name, email, secret) async {
  PostgreSQLConnection? connection = await getConnection();
  await connection?.query('''
      INSERT INTO teacher_users (First_Name, Last_Name, email, secret)
      VALUES ('$First_Name', '$Last_Name', '$email', '$secret')
    ''');
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
  String Club_Name,
      Days,
      Room,
      Presidents_First_Name,
      Presidents_Last_Name,
      Presidents_Bronx_Science_Email,
      CoPresidentVice_Presidents_First_Name,
      CoPresidentVice_Presidents_Last_Name,
      CoPresidentsVice_Presidents_Bronx_Science_Email,
      Secretarys_First_Name,
      Secretarys_Last_Name,
      Secretarys_Bronx_Science_Email,
      Advisor_Names,
      Advisors_Bronx_Science_Emails;
  Club(
    this.Club_Name,
    this.Days,
    this.Room,
    this.Presidents_First_Name,
    this.Presidents_Last_Name,
    this.Presidents_Bronx_Science_Email,
    this.CoPresidentVice_Presidents_First_Name,
    this.CoPresidentVice_Presidents_Last_Name,
    this.CoPresidentsVice_Presidents_Bronx_Science_Email,
    this.Secretarys_First_Name,
    this.Secretarys_Last_Name,
    this.Secretarys_Bronx_Science_Email,
    this.Advisor_Names,
    this.Advisors_Bronx_Science_Emails,
  );
}
