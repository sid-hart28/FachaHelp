import 'package:facha_help/constants.dart';
import 'package:facha_help/screens/answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:facha_help/components/bluebutton.dart';
import 'package:facha_help/components/sidebar.dart';
import 'package:facha_help/services/discussion_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:facha_help/components/footer_item.dart';

class DiscussionScreen extends StatefulWidget {
  static const String id = 'discussion_screen';
  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  String askedQuestion, askedQWriter;
  List apiQData;
  List<Widget> containersList;
  DiscussionApi discussionApi = DiscussionApi();
  bool showSpinner = false, haveData = false;
  List qIds;

  Future<void> getQDataList() async {
    apiQData = await discussionApi.getQuestions();
    getContainers(apiQData);
    setState(() {
      haveData = true;
    });
  }

  void getContainers(List dataList) {
    setState(() {
      containersList = [];
      qIds = [];
      int l = dataList.length;
      for (var i = l - 1; i >= 0; i--) {
        String wName = dataList[i]["writer_name"],
            qBody = dataList[i]["q_body"];
        qIds.add(dataList[l - i - 1]["_id"]);
        containersList.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              decoration: kBoxDecoration,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      qBody,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Text(
                          "Asked by $wName",
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.grey[600]),
                        ),
                        Expanded(child: SizedBox()),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3.0, color: Colors.grey)
                                  ]),
                              height: 40.0,
                              width: 60.0,
                              child: PopupMenuButton(
                                onSelected: (value) async {
                                  if (value == "Delete") {
                                    print(qIds[i]);
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    await discussionApi.deleteQuestion(qIds[i]);
                                    await getQDataList();
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  } else if (value == "Edit") {
                                    print("$value clicked!");
                                    setState(() {
                                      updateContainer(
                                          l - i - 1, wName, qBody, qIds[i]);
                                    });
                                  }
                                },
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AnswerScreen(
                                                currentQdata: [
                                                  qIds[i],
                                                  qBody,
                                                  wName
                                                ])));
                              },
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
    });
  }

  void updateContainer(int j, String wname, String ques, String qid) {
    String editedQuestion;
    containersList[j] = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: kBoxDecoration,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: TextEditingController(text: ques),
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: kTextFieldDecoration,
                onChanged: (value) {
                  editedQuestion = value;
                },
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Text(
                    "Asked by $wname",
                    style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
                  ),
                  Expanded(child: SizedBox()),
                  BlueButton(
                    width: 120,
                    title: "Edit Question",
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      await discussionApi.updateQuestion(qid, editedQuestion);
                      await getQDataList();
                      setState(() {
                        showSpinner = false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getQDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF343A40),
        title: Text('Facha Help'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                showSpinner = true;
              });
              await getQDataList();
              setState(() {
                showSpinner = false;
              });
            },
          )
        ],
      ),
      drawer: SideBar(),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 36.0),
            children: [
              Container(
                decoration: kBoxDecoration,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter question you wanna ask...'),
                          onChanged: (value) {
                            askedQuestion = value;
                          },
                        ),
                      ),
                      TextField(
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your first name...'),
                        onChanged: (value) {
                          askedQWriter = value;
                        },
                      ),
                      BlueButton(
                        onPressed: () async {
                          print(askedQuestion);
                          setState(() {
                            showSpinner = true;
                          });
                          await discussionApi.postQuestion(
                              askedQuestion, askedQWriter);
                          await getQDataList();
                          setState(() {
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
              Column(
                children: haveData
                    ? (containersList.length != 0
                        ? containersList
                        : [
                            Container(
                              decoration: kBoxDecoration,
                              height: 350.0,
                              alignment: Alignment.center,
                              child: Text(
                                'Be first one to ask question here',
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ),
                          ])
                    : [CircularProgressIndicator()],
              ),
              SizedBox(height: 20.0),
              FooterItems(),
            ],
          ),
        ),
      ),
    );
  }
}
