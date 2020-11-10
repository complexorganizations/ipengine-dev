import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class PricingPageTablet extends StatefulWidget {
  @override
  _PricingPageTabletState createState() => _PricingPageTabletState();
}

class _PricingPageTabletState extends State<PricingPageTablet> {
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
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: 170, bottom: 20, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 25, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: colorEEEEEE),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: lightHintColor, blurRadius: 4, spreadRadius:3,
                    //   )
                    // ]
                  ),
                  child: Column(
                    children: [
                      _textWidget(text: "Geolocation", background: ""),
                      _textWidget(text: "ASN", background: null),
                      _textWidget(text: "Abuse", background: ""),
                      _textWidget(text: "Privacy Detection", background: null),
                      _textWidget(text: "Hosted Domains", background: ""),
                      _textWidget(text: "Carrier", background: null),
                      _textWidget(text: "Company", background: ""),
                      _textWidget(text: "IP Ranges", background: null),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                          color: colorBBBBBB, blurRadius: 2, spreadRadius: 3),
                    ],
                  ),
                  child: Container(
                    height: 165,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                    decoration: BoxDecoration(
                      color: btnBgColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text("\$0.00",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600)),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2, color: color555555))),
                            ),
                            Text(
                              " / Free",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Can you imagine all these expensive services been served for free!?",
                          style: TextStyle(fontSize: 14, color: color555555),
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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Image.asset('assets/pricingImg.png'),
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

  Widget _textWidget({text, background}) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 38,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: background == null ? Colors.transparent : colorF9F9F9,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(text),
    );
  }
}
