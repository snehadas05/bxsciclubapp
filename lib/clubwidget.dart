import 'package:flutter/material.dart';
import 'db.dart';
import 'clubhp.dart';

class ClubWidget extends StatefulWidget {
  final String clubName;
  final String email;

  const ClubWidget({super.key, required this.clubName, required this.email});

  @override
  State<ClubWidget> createState() => _ClubWidgetState();
}

class _ClubWidgetState extends State<ClubWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClubHomepage(
                        clubname: widget.clubName,
                        useremail: widget.email,
                      )));
        }),
        child: SizedBox(
            width: 500,
            height: 100,
            child: Card(
                elevation: 3,
                color: Color.fromARGB(255, 149, 212, 187),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const SizedBox(width: 15),
                        Text(
                          widget.clubName,
                        ),
                        const SizedBox(height: 20),
                      ]),
                ))));
  }
}
