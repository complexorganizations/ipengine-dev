import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class SettingPagetablet extends StatefulWidget {
  @override
  _SettingPagetabletState createState() => _SettingPagetabletState();
}

class _SettingPagetabletState extends State<SettingPagetablet> {
  bool _switch = true;

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
                Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.only(right: 90),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(right: BorderSide(color: colorDDDDDD)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Column(
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
                                      spreadRadius: 2,
                                      blurRadius: 2)
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
                            height: 10,
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
                                      spreadRadius: 2,
                                      blurRadius: 2)
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
                                      fontSize: 16, color: exitBtnTextColor),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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
                Column(
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
                          EdgeInsets.symmetric(horizontal: 17, vertical: 11),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: colorF5F5F5,
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
                          EdgeInsets.symmetric(horizontal: 17, vertical: 11),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: colorF5F5F5,
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
                          EdgeInsets.symmetric(horizontal: 17, vertical: 11),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: colorF5F5F5,
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
                          EdgeInsets.symmetric(horizontal: 17, vertical: 11),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: colorF5F5F5,
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
                Positioned(
                  right: 0,
                  bottom: 15,
                  child: Container(
                    width: 264,
                    height: 51,
                    decoration: BoxDecoration(
                        color: colorF9F9F9,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: colorBBBBBB,
                            blurRadius: 4,
                            spreadRadius: 3,
                          )
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Chat with us",
                                border: InputBorder.none,
                              ),
                              controller: TextEditingController(),
                            ),
                          ),
                        ),
                        Container(
                          height: 51,
                          width: 51,
                          child: Image.asset('assets/message.png'),
                        )
                      ],
                    ),
                  ),
                )
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
