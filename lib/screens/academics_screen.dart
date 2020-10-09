import 'package:flutter/material.dart';
import 'package:facha_help/components/sidebar.dart';
import 'package:facha_help/components/footer_item.dart';

class AcademicsScreen extends StatelessWidget {
  static const String id = 'academics_screen';
  static const String semesterSystem1 =
      "The acedemic session of the Institute is divided into three parts: two regular semeters and a summer term (though as fresher you need not to worry about summer term).Among regular semester the odd semester normally commences in the last week of July every year, and even semester in the first week of January.";
  static const String semesterSystem2 =
      "Academic calender of the institute for various academic activities for all of the students of the institute will/is available on the welsite of each semester.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF343A40),
        title: Text('Facha Help'),
      ),
      drawer: SideBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Semester System',
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(height: 20.0),
              Text(
                semesterSystem1,
                style: TextStyle(color: Colors.black38, fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Text(
                semesterSystem2,
                style: TextStyle(color: Colors.black38, fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              FooterItems(),
            ],
          ),
        ),
      ),
    );
  }
}
