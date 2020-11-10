import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class PricingPageWeb extends StatefulWidget {
  @override
  _PricingPageWebState createState() => _PricingPageWebState();
}

class _PricingPageWebState extends State<PricingPageWeb> {
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
                    border: Border.all(width: 2, color: colorEEEEEE),
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
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 4,
                          spreadRadius: 3),
                    ],
                  ),
                  child: Container(
                    height: 165,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                    decoration: BoxDecoration(
                      color: colorE8F1FF,
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
                            Expanded(
                                child: Text(
                              " / Free",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Can you imagine all these expensive services been served for free!?",
                          maxLines: 2,
                          overflow: TextOverflow.fade,
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
