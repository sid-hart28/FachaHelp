import 'package:facha_help/components/footer_item.dart';
import 'package:facha_help/services/discussion_api.dart';
import 'package:flutter/material.dart';
import 'package:facha_help/constants.dart';
import 'package:facha_help/components/bluebutton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AnswerScreen extends StatefulWidget {
  static const String id = 'answer_screen';
  final List currentQdata;
  AnswerScreen({Key key, @required this.currentQdata}) : super(key: key);

  @override
  _AnswerScreenState createState() => _AnswerScreenState(currentQdata);
}

class _AnswerScreenState extends State<AnswerScreen> {
  List currentQData;
  _AnswerScreenState(this.currentQData);

  DiscussionApi discussionApi = DiscussionApi();
  List apiAData, ansIds;
  String inputAnswer, inputAWriter;
  List<Widget> containersAList;
  bool showSpinner = false, haveData = false;

  Future<void> getADataList() async {
    apiAData = await discussionApi.getAnswers(currentQData[0]);
    getContainers(apiAData);
    setState(() {
      haveData = true;
    });
  }

  void getContainers(List dataList) {
    setState(() {
      containersAList = [];
      ansIds = [];
      int l = dataList.length;
      for (var i = l - 1; i >= 0; i--) {
        ansIds.add(dataList[l - i - 1]["_id"]);
        String ansBody = dataList[i]["a_body"],
            wName = dataList[i]["writer_name"];
        containersAList.add(
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
                      "😊By $wName",
                      style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      children: [
                        Text(
                          ansBody,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Expanded(child: SizedBox()),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              boxShadow: [
                                BoxShadow(blurRadius: 3.0, color: Colors.grey)
                              ]),
                          height: 40.0,
                          width: 60.0,
                          child: PopupMenuButton(
                            onSelected: (value) async {
                              if (value == "Delete") {
                                print(ansIds[i]);
                                setState(() {
                                  showSpinner = true;
                                });
                                await discussionApi.deleteAnswer(
                                    currentQData[0], ansIds[i]);
                                await getADataList();
                                setState(() {
                                  showSpinner = false;
                                });
                              } else if (value == "Edit") {
                                print("$value clicked!");

                                setState(() {
                                  updateContainer(
                                      l - i - 1, wName, ansBody, ansIds[i]);
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

  void updateContainer(int j, String wname, String ans, String ansId) {
    String editedAnswer;
    containersAList[j] = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: kBoxDecoration,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "😊By $wname",
                style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
              ),
              SizedBox(height: 15.0),
              TextField(
                controller: TextEditingController(text: ans),
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: kTextFieldDecoration,
                onChanged: (value) {
                  editedAnswer = value;
                },
              ),
              BlueButton(
                width: 110,
                title: "Edit Answer",
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  await discussionApi.updateAnswer(
                      currentQData[0], ansId, editedAnswer);
                  await getADataList();
                  setState(() {
                    showSpinner = false;
                  });
                },
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
    getADataList();
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
              await getADataList();
              setState(() {
                showSpinner = false;
              });
            },
          )
        ],
      ),
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
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Question By ${currentQData[2]}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            "x hours ago",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        currentQData[1],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
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
                              hintText: 'Enter your answer...'),
                          onChanged: (value) {
                            inputAnswer = value;
                          },
                        ),
                      ),
                      TextField(
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your first name...'),
                        onChanged: (value) {
                          inputAWriter = value;
                        },
                      ),
                      BlueButton(
                        onPressed: () async {
                          print(inputAnswer);
                          setState(() {
                            showSpinner = true;
                          });
                          await discussionApi.postAnswer(
                              currentQData[0], inputAnswer, inputAWriter);
                          await getADataList();
                          setState(() {
                            showSpinner = false;
                          });
                        },
                        title: 'Submit',
                        width: 80.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Column(
                children: haveData
                    ? (containersAList.length != 0
                        ? containersAList
                        : [
                            Container(
                              decoration: kBoxDecoration,
                              height: 200.0,
                              alignment: Alignment.center,
                              child: Text(
                                'Be first one to answer this question',
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
