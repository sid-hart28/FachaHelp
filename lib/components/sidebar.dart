import 'package:flutter/material.dart';
import 'drawerbutton.dart';
import 'package:facha_help/screens/discussion_screen.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              'User info',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF343A40),
            ),
          ),
          DrawerItemTiles(
            title: 'Discussion Forum',
            onTap: () {
              Navigator.pushNamed(context, DiscussionScreen.id);
            },
          ),
          DrawerItemTiles(
            title: 'Registration Guide',
          ),
          DrawerItemTiles(
            title: 'Academics',
          ),
          DrawerItemTiles(
            title: 'Fests',
          ),
          DrawerItemTiles(
            title: 'Gymkhana',
          ),
          DrawerItemTiles(
            title: 'Explore Varanasi',
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: DropdownButton<String>(
                hint: Text(
                  'More',
                  style: TextStyle(
                    color: Color(0xFF343A40),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('Gallery'),
                    value: 'A',
                  ),
                  DropdownMenuItem(
                    child: Text('Placement Stats'),
                    value: 'B',
                  ),
                  DropdownMenuItem(
                    child: Text('IIT BHU on web'),
                    value: 'C',
                  ),
                  DropdownMenuItem(
                    child: Text('Misc.'),
                    value: 'D',
                  ),
                ],
                onChanged: (value) {}),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: DropdownButton<String>(
                hint: Text(
                  'Get in Touch',
                  style: TextStyle(
                    color: Color(0xFF343A40),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('About Us'),
                    value: 'A',
                  ),
                  DropdownMenuItem(
                    child: Text('Feedback'),
                    value: 'B',
                  ),
                  DropdownMenuItem(
                    child: Text('Terms and Conditions'),
                    value: 'C',
                  ),
                ],
                onChanged: (value) {}),
          ),
        ],
      ),
    );
  }
}
