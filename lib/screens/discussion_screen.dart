import 'package:facha_help/constants.dart';
import 'package:facha_help/soc_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:facha_help/components/bluebutton.dart';
import 'package:facha_help/components/sidebar.dart';

class DiscussionScreen extends StatefulWidget {
  static const String id = 'discussion_screen';
  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF343A40),
        title: Text('Facha Help'),
      ),
      drawer: SideBar(),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter question you wanna ask...'),
                            ),
                          ),
                          TextField(
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Enter your first name...'),
                          ),
                          BlueButton(
                            onPressed: () {},
                            title: 'Ask',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 350.0,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'Be first one to ask question here',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Column(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
