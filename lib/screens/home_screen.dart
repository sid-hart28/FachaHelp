import 'package:flutter/material.dart';
import 'package:facha_help/components/sidebar.dart';
import 'package:facha_help/soc_icons_icons.dart';
import 'package:facha_help/components/footer_item.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('HOME'),
              SizedBox(height: 20.0),
              FooterItems(),
            ],
          ),
        ),
      ),
    );
  }
}
