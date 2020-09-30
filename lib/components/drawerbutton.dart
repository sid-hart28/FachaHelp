import 'package:flutter/material.dart';

class DrawerItemTiles extends StatelessWidget {
  DrawerItemTiles({@required this.title, this.onTap});
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Color(0xFF343A40), fontSize: 16.0),
      ),
      onTap: onTap,
    );
  }
}
