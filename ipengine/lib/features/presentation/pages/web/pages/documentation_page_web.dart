import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ipengine/features/presentation/pages/web/documentation_page_widget/model.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DocumentationPageWeb extends StatefulWidget {
  @override
  _DocumentationPageWebState createState() => _DocumentationPageWebState();
}

class _DocumentationPageWebState extends State<DocumentationPageWeb> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }

  List<Widget> list = [
    Text("hello there"),
    Container(
      height: 10,
      width: 20,
      color: Colors.red,
    ),
    Container(
      height: 100,
      width: 80,
      color: Colors.grey,
    ),
    Text("hello there 1"),
    Container(
      height: 60,
      width: 100,
      color: Colors.green,
    ),
    Container(
      height: 50,
      width: 20,
      color: Colors.yellowAccent,
    ),
    Text("hello there 09"),
    Container(
      height: 60,
      width: 20,
      color: Colors.red,
    ),
  ];
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return _bodyRowWidget();
  }

  Widget _bodyRowWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 580,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: colorBBBBBB,
                            blurRadius: 4,
                            spreadRadius: 3,
                          )
                        ]),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 550,
                      ),
                      child: Theme(
                        data: ThemeData(highlightColor: colorFFDE8A),
                        child: Scrollbar(
                          controller: ScrollController(initialScrollOffset: 0),
                          isAlwaysShown: true,
                          thickness: 8,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: colorF9F9F9,
                              // border: Border.all(width: 1, color: strokeColorEEEEEE),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    height: 21,
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: "Getting started with",
                                          style: TextStyle(
                                              color: color999999, fontSize: 14),
                                        ),
                                        TextSpan(
                                          text: " IPengine,",
                                          style: TextStyle(
                                              color: colorF8733A, fontSize: 14),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      itemScrollController.scrollTo(
                                          index: 0,
                                          duration: Duration(milliseconds: 600),
                                          curve: Curves.easeInOutCubic);
                                    },
                                    child: _textWidget(
                                      text: "Introduction to IPengine",
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      itemScrollController.scrollTo(
                                          index: 1,
                                          duration: Duration(milliseconds: 600),
                                          curve: Curves.easeInOutCubic);
                                    },
                                    child: _textWidget(
                                      text: "Key Concepts",
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      itemScrollController.scrollTo(
                                          index: 2,
                                          duration: Duration(milliseconds: 600),
                                          curve: Curves.easeInOutCubic);
                                    },
                                    child: _textWidget(
                                      text: "Workflow",
                                    ),
                                  ),
                                  InkWell(
                                    child: _textWidget(
                                      text: "Writing Instructions",
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      itemScrollController.scrollTo(
                                          index: 3,
                                          duration: Duration(milliseconds: 600),
                                          curve: Curves.easeInOutCubic);
                                    },
                                    child: _textWidget(
                                      text: "Task Types",
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      itemScrollController.scrollTo(
                                          index: 4,
                                          duration: Duration(milliseconds: 600),
                                          curve: Curves.easeInOutCubic);
                                    },
                                    child: _textWidget(
                                      text: "First time using an API",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 40),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      height: 21,
                                      child: Text(
                                        "Customer Dashboard",
                                        style: TextStyle(
                                            color: color999999, fontSize: 14),
                                      )),
                                  _textWidget(
                                    text: "Manage your Account",
                                  ),
                                  _textWidget(
                                    text: "Manage your projects",
                                  ),
                                  _textWidget(
                                    text: "Overview Tabs",
                                  ),
                                  _textWidget(
                                    text: "Tasks Tab",
                                  ),
                                  _textWidget(
                                    text: "Quality Tab",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 40),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      height: 21,
                                      child: Text(
                                        "Data Hosting",
                                        style: TextStyle(
                                            color: color999999, fontSize: 14),
                                      )),
                                  _textWidget(
                                    text: "Secure Attachment Access",
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 40),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      height: 21,
                                      child: Text(
                                        "Get Support",
                                        style: TextStyle(
                                            color: color999999, fontSize: 14),
                                      )),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    height: 21,
                                    child: Text(
                                      "Communities",
                                      style: TextStyle(
                                          color: color999999, fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
          ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ScrollablePositionedList.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: documentationPageListWidget.length,
                            itemScrollController: itemScrollController,
                            itemPositionsListener: itemPositionsListener,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 80),
                                child: documentationPageListWidget[index],
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _textWidget({text}) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}
