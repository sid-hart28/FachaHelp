import 'package:flutter/material.dart';
import 'package:facha_help/soc_icons_icons.dart';

class FooterItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(SocIcons.facebook),
            SizedBox(width: 15.0),
            Icon(SocIcons.instagram),
            SizedBox(width: 15.0),
            Icon(SocIcons.linkedin),
            SizedBox(width: 15.0),
            Icon(SocIcons.twitter),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Har Har Mahadev\n\nSab Lite Hai!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.0),
        ),
      ],
    );
  }
}
