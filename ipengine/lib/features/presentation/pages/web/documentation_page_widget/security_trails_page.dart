import 'package:flutter/material.dart';
import 'package:ipengine/features/domain/entity/security_tirils_entity.dart';
import 'package:ipengine/features/presentation/pages/web/widgets/common.dart';

class SecurityTrailsPage extends StatefulWidget {
  @override
  _SecurityTrailsPageState createState() => _SecurityTrailsPageState();
}

class _SecurityTrailsPageState extends State<SecurityTrailsPage> {
  int _selectedMenuItem = -1;
  final _listData = SecurityTrailsEntity.securityTrailsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _headerWidget(),
            _bodyWidget(),
          ],
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "IPengine.dev",
                style: textStyle24,
              ),
              SizedBox(
                width: 10,
              ),
              _searchWidget(),
            ],
          ),
          Row(
            children: [
              Text("Login"),
              SizedBox(
                width: 10,
              ),
              Text("SignUp for Free")
            ],
          )
        ],
      ),
    );
  }

  Widget _searchWidget() {
    return Container(
      padding: EdgeInsets.only(left: 15),
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.2),
      ),
      width: MediaQuery.of(context).size.width / 3,
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search",
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 20),
            suffixIcon: Container(
              alignment: Alignment.center,
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Icon(Icons.search),
            )),
      ),
    );
  }

  Widget _bodyWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: _menuWidget()),
        Expanded(flex: 4, child: _listDataWidget()),
      ],
    );
  }

  Widget _menuWidget() {
    return Container(
      color: Colors.black.withOpacity(.2),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _menuItemHeaderWidget(color: Colors.transparent, text: "DOMAIN"),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 0;
              });
            },
            child: _menuItemWidget(
                color: Colors.green,
                text: "DNS Records",
                selectItemColor: _selectedMenuItem == 0
                    ? Colors.green.withOpacity(.2)
                    : Colors.transparent),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 1;
              });
            },
            child: _menuItemWidget(
              color: Colors.blue,
              text: "Historical Data",
              selectItemColor: _selectedMenuItem == 1
                  ? Colors.blue.withOpacity(.2)
                  : Colors.transparent,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 2;
              });
            },
            child: _menuItemWidget(
              color: Colors.red,
              text: "Subdomains",
              selectItemColor: _selectedMenuItem == 2
                  ? Colors.red.withOpacity(.2)
                  : Colors.transparent,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedMenuItem = 3;
              });
            },
            child: _menuItemWidget(
                color: Colors.lightBlueAccent,
                text: "Sign Up for an API Key Now!",
                selectItemColor: _selectedMenuItem == 3
                    ? Colors.lightBlueAccent.withOpacity(.2)
                    : Colors.transparent),
          ),
        ],
      ),
    );
  }

  Widget _listDataWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "goole.com current DNS records",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.builder(
            itemCount: _listData.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(8.0),
                height: 220,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(.2)),
                      child: Row(
                        children: [
                          _listData[index].heading == ""
                              ? Text(
                                  "",
                                  style: TextStyle(fontSize: 0),
                                )
                              : Container(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    _listData[index].heading,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                          _listData[index].subHeading == ""
                              ? Text(
                                  "",
                                  style: TextStyle(fontSize: 0),
                                )
                              : Container(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    _listData[index].subHeading,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black.withOpacity(.7),
                                    ),
                                  ),
                                ),
                          _listData[index].headingValue == ""
                              ? Text("")
                              : Container(
                                  padding: EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      )),
                                  child: Text(
                                    _listData[index].headingValue,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        _listData[index].title,
                        style: TextStyle(
                            fontSize: 15, color: Colors.black.withOpacity(.6)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: _listData[index].ipData.length,
                      itemBuilder: (BuildContext context, int innerIndex) {
                        return Container(
                          padding: EdgeInsets.only(left: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      _listData[index]
                                                  .ipData[innerIndex]
                                                  .leftValue ==
                                              ""
                                          ? Text(
                                              "",
                                              style: TextStyle(fontSize: 0),
                                            )
                                          : Text(_listData[index]
                                              .ipData[innerIndex]
                                              .leftValue),
                                      _listData[index]
                                                  .ipData[innerIndex]
                                                  .title ==
                                              ""
                                          ? Text(
                                              "",
                                              style: TextStyle(fontSize: 0),
                                            )
                                          : Text(
                                              _listData[index]
                                                  .ipData[innerIndex]
                                                  .title,
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                    ],
                                  ),
                                  _listData[index].ipData[innerIndex].value ==
                                          ""
                                      ? Text(
                                          "",
                                          style: TextStyle(fontSize: 0),
                                        )
                                      : Text(_listData[index]
                                          .ipData[innerIndex]
                                          .value),
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _menuItemWidget({Color color, String text, Color selectItemColor}) {
    return Container(
      height: 55,
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 6, color: color)),
          color: selectItemColor),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _menuItemHeaderWidget({Color color, String text}) {
    return Container(
      height: 55,
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 6, color: color)),
          color: Colors.black.withOpacity(.1)),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
