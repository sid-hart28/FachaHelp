import 'package:flutter/material.dart';

class DrawerItemTiles extends StatelessWidget {
  DrawerItemTiles({@required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Color(0xFF343A40), fontSize: 16.0),
      ),
      onTap: () {
        // Update the state of the app.
        // ...
      },
    );
  }
}
