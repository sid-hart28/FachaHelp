import 'package:facha_help/screens/discussion_screen.dart';
import 'package:flutter/material.dart';
import 'package:facha_help/screens/home_screen.dart';
import 'package:facha_help/screens/academics_screen.dart';

void main() => runApp(FachaHelp());

class FachaHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        DiscussionScreen.id: (context) => DiscussionScreen(),
        AcademicsScreen.id: (context) => AcademicsScreen(),
      },
    );
  }
}
