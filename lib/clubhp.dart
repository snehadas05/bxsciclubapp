import 'package:flutter/material.dart';
import 'colors.dart';
import 'db.dart';
import 'homepage.dart';

class ClubHomepage extends StatelessWidget {
  ClubHomepage({required this.clubname, required this.useremail});
  final String clubname;
  final String useremail;

//   @override
//   State<ClubHomepage> createState() =ClubHomepageState;();
// }
// class ClubHomepageState extends State<ClubHomepage> {
//   final Club c;
//   final String email;
//   final emailcontroller = TextEditingController();
//   final passwordcontroller = TextEditingController();
//   String password = '';

//   ClubHomepageState(this.c, this.email);
//   @override
//   void initState() {
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: beaublue,
        body: Stack(children: [
          Column(children: <Widget>[
            Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: xanadu, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    bool joined = await joinClub(useremail, clubname);
                    if (joined = true) {
                      AlertDialog(
                        iconColor: xanadu,
                        semanticLabel: 'club joined',
                      );
                    } else {
                      AlertDialog(
                        iconColor: xanadu,
                        semanticLabel: 'you are already in this club',
                      );
                    }
                  },
                  child: Text(
                    'JOIN CLUB',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/icon.jpeg')),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(clubname),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: FutureBuilder<String>(
                    future: getPres(clubname),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String data = snapshot.data!;
                        return Text(data);
                      } else {
                        return Text('no data availible');
                      }
                    })),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: FutureBuilder<String>(
                    future: meetingInfo(clubname),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String data = snapshot.data!;
                        return Text(data);
                      } else {
                        return Text('no data availible');
                      }
                    })),
            Container(
              height: 100,
              width: 120,
            ),
            Container(
                height: 20,
                width: 120,
                decoration: BoxDecoration(
                    color: xanadu, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HomePage(useremail: useremail)));
                  },
                  child: Text(
                    'Return to Home',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ))
          ]),
        ]));
  }
}
