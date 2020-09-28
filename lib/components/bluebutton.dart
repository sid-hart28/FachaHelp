import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  BlueButton({@required this.onPressed, this.title});
  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blueAccent,
          boxShadow: [
            BoxShadow(blurRadius: 2.0, color: Colors.blueGrey),
          ],
        ),
        width: 50.0,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
