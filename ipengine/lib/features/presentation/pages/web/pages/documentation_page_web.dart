import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

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
                        // border: Border.all(width: 1, color: strokeColorEEEEEE),
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
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: colorF9F9F9,
                            // border: Border.all(width: 1, color: strokeColorEEEEEE),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8,),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.symmetric(horizontal: 40),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                height: 21,
                                child: Row(
                                  children: [
                                    Text(
                                      "Getting started with",
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style:
                                          TextStyle(color: color999999, fontSize: 14),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " IPengine,",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            TextStyle(color: colorF8733A, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _textWidget(
                                text: "Introduction to IPengine",
                              ),
                              _textWidget(
                                text: "Key Concepts",
                              ),
                              _textWidget(
                                text: "Workflow",
                              ),
                              _textWidget(
                                text: "Writing Instructions",
                              ),
                              _textWidget(
                                text: "Task Types",
                              ),
                              _textWidget(
                                text: "First time using an API",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: 21,
                                  child: Text(
                                    "Customer Dashboard",
                                    style:
                                        TextStyle(color: color999999, fontSize: 14),
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
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: 21,
                                  child: Text(
                                    "Data Hosting",
                                    style:
                                        TextStyle(color: color999999, fontSize: 14),
                                  )),
                              _textWidget(
                                text: "Secure Attachment Access",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: 21,
                                  child: Text(
                                    "Get Support",
                                    style:
                                        TextStyle(color: color999999, fontSize: 14),
                                  )),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: 21,
                                  child: Text(
                                    "Communities",
                                    style:
                                        TextStyle(color: color999999, fontSize: 14),
                                  )),
                            ],
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
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Introduction to IPengine",
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Easy Peasy Lemon Squeezy",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          height: 390,
                          width: 660,
                          alignment: Alignment.center,
                          child: Image.asset('assets/docImg.png',fit: BoxFit.contain,),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "The quickest and easiest way to get started with IPinfo is to use one of our official libraries, which are available for many popular programming languages and frameworks. If you'd like to write your own library or interact directly with our API then the documentation below can help you.",
                        style: TextStyle(
                          fontSize: 14,
                          color: color555555,
                        ),
                      )
                    ],
                  ),
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
      margin: EdgeInsets.symmetric(horizontal: 40,vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
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
