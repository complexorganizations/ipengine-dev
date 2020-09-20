import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_ui/config/assets.dart';
import 'package:web_ui/widgets/centered_view.dart';
import 'package:web_ui/widgets/chat_with_us.dart';
import 'package:web_ui/widgets/header_row.dart';

class DocumentaionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CenteredView(
        child: Column(
          children: [
            HeaderRow(),
            Expanded(
              child: ListView(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _LeftWidget(),
                        _RightWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RightWidget extends StatelessWidget {
  const _RightWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Introduction to IPengine",
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontStyle: FontStyle.normal,
                      fontSize: 30.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Easy Peasy Lemon Squeezy",
                  style: const TextStyle(
                      color: const Color(0xff555555),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Image.asset(Assets.easyPeasy),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 19.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "The quickest and easiest way to get started with IPinfo is to use one of our official libraries, which are available for many popular programming languages and frameworks. If you'd like to write your own library or interact directly with our API then the documentation below can help you.",
                    style: const TextStyle(
                        color: const Color(0xff555555),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(child: ChatWithUs()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeftWidget extends StatefulWidget {
  _LeftWidget({
    Key key,
  }) : super(key: key);

  @override
  __LeftWidgetState createState() => __LeftWidgetState();
}

class __LeftWidgetState extends State<_LeftWidget> {
  ScrollController _customScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 334,
        height: 560,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color(0xffffffff), width: 10),
          boxShadow: [
            BoxShadow(
                color: const Color(0x1a000000),
                offset: Offset(0, 8),
                blurRadius: 20,
                spreadRadius: 0)
          ],
          color: const Color(0xfff9f9f9),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 37.0, left: 24.0),
          child: _CustomDocumentaionScroll(controller: _customScrollController),
        ),
      ),
    );
  }
}

class _CustomDocumentaionScroll extends StatelessWidget {
  const _CustomDocumentaionScroll({Key key, @required this.controller})
      : super(key: key);

  final ScrollController controller;

  Widget _buildLeftDocumentaionText(
    String text, {
    bool isGreyHeading = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0, bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color:
              isGreyHeading ? const Color(0xff999999) : const Color(0xff000000),
          fontWeight: isGreyHeading ? FontWeight.w600 : FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar(
      alwaysVisibleScrollThumb: true,
      controller: controller,
      child: ListView.builder(
        controller: controller,
        itemCount: Assets.documentaionTexts.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      style: const TextStyle(
                          color: const Color(0xff999999),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      text: "Getting started with "),
                  TextSpan(
                      style: const TextStyle(
                          color: const Color(0xfff8733a),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      text: "IPengine")
                ],
              ),
            );
          }
          if (index == 6 || index == 12 || index == 14) {
            return _buildLeftDocumentaionText(Assets.documentaionTexts[index],
                isGreyHeading: true);
          }
          return _buildLeftDocumentaionText(Assets.documentaionTexts[index]);
        },
      ),
      heightScrollThumb: 0.0,
      backgroundColor: Colors.blue,
      scrollThumbBuilder: (
        Color backgroundColor,
        Animation<double> thumbAnimation,
        Animation<double> labelAnimation,
        double height, {
        Text labelText,
        BoxConstraints labelConstraints,
      }) {
        return Container(
          width: 9,
          height: 286,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xffffde8a),
          ),
        );
      },
    );
  }
}
