import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  BlueButton({@required this.onPressed, this.title, this.width});
  final Function onPressed;
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blueAccent,
          boxShadow: [
            BoxShadow(blurRadius: 1.0, color: Colors.blueGrey),
          ],
        ),
        width: width,
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
