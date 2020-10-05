import 'package:facha_help/constants.dart';
import 'package:facha_help/soc_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:facha_help/components/bluebutton.dart';
import 'package:facha_help/components/sidebar.dart';
import 'package:facha_help/services/discussion_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DiscussionScreen extends StatefulWidget {
  static const String id = 'discussion_screen';
  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  String question;
  String writer;
  List<Widget> containersList = new List<Widget>();
  DiscussionApi discussionApi = DiscussionApi();
  Future<List> futureData;
  bool showSpinner = false;

  void popMenuFunc(value) {
    print("$value clicked");
  }

  void getContainers(List dataList) {
    containersList = [];
    for (var i = dataList.length - 1; i >= 0; i--) {
      containersList.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataList[i]["q_body"],
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    children: [
                      Text(
                        "Asked by ${dataList[i]["writer_name"]}",
                        style:
                            TextStyle(fontSize: 13.0, color: Colors.grey[600]),
                      ),
                      Expanded(child: SizedBox()),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                boxShadow: [
                                  BoxShadow(blurRadius: 3.0, color: Colors.grey)
                                ]),
                            height: 40.0,
                            width: 60.0,
                            child: PopupMenuButton(
                              onSelected: popMenuFunc,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.tune,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                ],
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: "Edit",
                                  child: Text('Edit'),
                                ),
                                PopupMenuItem(
                                  value: "Delete",
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                          BlueButton(
                            onPressed: () {},
                            width: 80.0,
                            title: "Answer",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    futureData = discussionApi.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF343A40),
        title: Text('Facha Help'),
      ),
      drawer: SideBar(),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
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
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: TextField(
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText:
                                        'Enter question you wanna ask...'),
                                onChanged: (value) {
                                  question = value;
                                },
                              ),
                            ),
                            TextField(
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Enter your first name...'),
                              onChanged: (value) {
                                writer = value;
                              },
                            ),
                            BlueButton(
                              onPressed: () async {
                                print(question);
                                setState(() {
                                  showSpinner = true;
                                });
                                await discussionApi.postData(question, writer);
                                setState(() {
                                  futureData = discussionApi.getData();
                                  showSpinner = false;
                                });
                              },
                              title: 'Ask',
                              width: 50.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FutureBuilder<List>(
                      future: futureData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          getContainers(snapshot.data);
                          return (Column(
                            children: snapshot.data.length != 0
                                ? containersList
                                : [
                                    Container(
                                      height: 350.0,
                                      color: Colors.white,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Be first one to ask question here',
                                        style: TextStyle(fontSize: 17.0),
                                      ),
                                    ),
                                  ],
                          ));
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
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
      ),
    );
  }
}
