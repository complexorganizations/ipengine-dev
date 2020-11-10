import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class SettingPageWeb extends StatefulWidget {
  @override
  _SettingPageWebState createState() => _SettingPageWebState();
}

class _SettingPageWebState extends State<SettingPageWeb> {
  bool _switch = false;
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
            flex: 3,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.only(right: 90),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(right: BorderSide(color: colorDDDDDD)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 184,
                              width: 184,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.2),
                                        spreadRadius: 1.5,
                                        blurRadius: 3)
                                  ]),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  child: Image.asset(
                                    'assets/prof_img_lg.png',
                                    fit: BoxFit.contain,
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Meliodas Ackerman",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "dragons.sin@gmail.com",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: color555555),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Text(
                              "Your IP",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: colorBBBBBB),
                            ),
                            Text(
                              "192.24.84.123",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colorFBBC05),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                width: 174,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.2),
                                          spreadRadius: 1.5,
                                          blurRadius: 4)
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Row(
                                  children: [
                                    Image.asset('assets/feebback.png'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Feedback",
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                height: 45,
                                width: 134,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.2),
                                          spreadRadius: 1.5,
                                          blurRadius: 4)
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Row(
                                  children: [
                                    Image.asset('assets/logout.png'),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Log Out",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: exitBtnTextColor),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
            flex: 6,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "API key",
                        style: TextStyle(color: color999999, fontSize: 12),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 41,
                        width: 365,
                        padding:
                            EdgeInsets.symmetric(horizontal: 17, vertical: 11),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: colorF5F5F5,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1.5,
                                  spreadRadius: 1.5,
                                  color: Colors.black.withOpacity(.1))
                            ],
                            border: Border.all(color: colorDDDDDD)),
                        child: Text(
                          "ifadp-f9uef-89nuq-wgerh-ic41n-123e4-1423n",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Settings",
                        style: TextStyle(color: color999999, fontSize: 12),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 41,
                        width: 365,
                        padding:
                            EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: colorFAFAFA,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1.5,
                                  spreadRadius: 1.5,
                                  color: Colors.black.withOpacity(.1))
                            ],
                            border: Border.all(color: colorEEEEEE)),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 41,
                        width: 365,
                        padding:
                            EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: colorFAFAFA,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1.5,
                                  spreadRadius: 1.5,
                                  color: Colors.black.withOpacity(.1))
                            ],
                            border: Border.all(color: colorEEEEEE)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "App Theme",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Switch(
                              value: _switch,
                              inactiveTrackColor: colorFBBC05,
                              activeColor: colorFBBC05,
                              onChanged: (value) {
                                setState(() {
                                  _switch = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 41,
                        width: 365,
                        padding:
                            EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: colorFAFAFA,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1.5,
                                  spreadRadius: 1.5,
                                  color: Colors.black.withOpacity(.1))
                            ],
                            border: Border.all(color: colorEEEEEE)),
                        child: Text(
                          "Change Owner",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 41,
                        width: 365,
                        padding:
                            EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: colorFAFAFA,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1.5,
                                  spreadRadius: 1.5,
                                  color: Colors.black.withOpacity(.1))
                            ],
                            border: Border.all(color: colorEEEEEE)),
                        child: Text(
                          "Temporarily Deactive Account",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 21,
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}
