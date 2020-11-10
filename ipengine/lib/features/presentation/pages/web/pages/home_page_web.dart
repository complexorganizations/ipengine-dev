import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ipengine/features/presentation/pages/web/pages/documentation_page_web.dart';
import 'package:ipengine/features/presentation/pages/web/pages/pricing_page_web.dart';
import 'package:ipengine/features/presentation/pages/web/pages/setting_page_web.dart';
import 'package:ipengine/features/presentation/pages/web/widgets/nav_bar/custom_nav_bar_web.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class HomePageWeb extends StatefulWidget {
  @override
  _HomePageWebState createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  String _text = """
  {
        network: {
                ip: "8.8.8.8",
                hostname: "dns.google.",
                reverse: "2001:4860:4860::8844",
                asn: "15169"
        },
        location: {
                country: "United States"
        },
        arin: {
                name: "LVLT-GOGL-8-8-8",
                handle: "NET-8-8-8-0-1",
                parent: "NET-8-0-0-0-1",
                type: "ALLOCATION",
                range: "8.8.8.0-8.8.8.255",
                cidr: "NET-8-8-8-0-1",
                status: [
                        "active"
                        }
                      
  """;

  ScrollController _scrollController;
  int _pageIndex = 0;

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  CustomNavBarWeb(
                    onPageIndexCallBack: (int pageIndex) {
                      setState(() {
                        _pageIndex = pageIndex;
                      });
                    },
                  ),
                  _bodyContent(),
                ],
              ),
            ),
          ),
          _pageIndex == -1
              ? Positioned(
                  right: 50,
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
              : Text(""),
        ],
      ),
    );
  }

  Widget _bodyContent() {
    if (_pageIndex == 0) {
      return Expanded(child: _bodyRowWidget());
    } else if (_pageIndex == 1) {
      return Expanded(child: SingleChildScrollView(child: PricingPageWeb()));
    } else if (_pageIndex == 2) {
      return Expanded(child: DocumentationPageWeb());
    } else if (_pageIndex == 3) {
      return Expanded(child: SettingPageWeb());
    } else
      return Container();
  }

  Widget _bodyRowWidget() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "The Trusted Source for IP Address Data",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    "With IPengine, you can pinpoint your users’ locations, customize their experiences, prevent fraud, ensure compliance, and so much more.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "\$0.00 per month, We know it’s expensive!",
                    style: TextStyle(
                        color: textOrgColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: color555555, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(0.2, 0.2))
                        ]),
                    child: Text(
                      "Get Started",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
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
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: colorF9F9F9,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: colorBBBBBB,
                                  blurRadius: 4,
                                  spreadRadius: 3,
                                )
                              ]),
                          child: Container(
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 400),
                              child: Theme(
                                data: ThemeData(
                                  highlightColor: colorFFDE8A,
                                ),
                                child: Scrollbar(
                                  controller: _scrollController,
                                  isAlwaysShown: true,
                                  child: TextField(
                                    style:
                                        TextStyle(wordSpacing: 1.0, height: 2),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    maxLines: null,
                                    controller:
                                        TextEditingController(text: _text),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    width: 221,
                    height: 51,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: btnBgColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      "IP 8.8.8.8",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
