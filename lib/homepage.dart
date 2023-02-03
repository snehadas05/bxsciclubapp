import 'package:flutter/material.dart';
import 'db.dart';
import 'clubwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.useremail});

  @override
  _HomePageState createState() => _HomePageState();
  final String useremail;
}

Future<List<String>> clubs = getAllClubs();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All Clubs'),
        ),
        body: Container(
            child: FutureBuilder<Widget>(
                future: clubWidgets(widget.useremail),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Widget data = snapshot.data!;
                    return SingleChildScrollView(child: data);
                  } else {
                    return Text('no data availible');
                  }
                })));
  }
}

void createClubWidget(String name) {}

Future<Widget> clubWidgets(String user) async {
  List<String> clubs = await getAllClubs();
  List<Widget> clubcards = [];
  for (int i = 0; i < clubs.length; i++) {
    String curr = clubs.elementAt(i);
    clubcards.add(ClubWidget(clubName: curr, email: user));
  }
  return (SingleChildScrollView(
      scrollDirection: Axis.vertical, child: Column(children: clubcards)));
}
