import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_ui/widgets/centered_view.dart';
import 'package:web_ui/widgets/chat_with_us.dart';
import 'package:web_ui/widgets/header_row.dart';

class HomePage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CenteredView(
        child: Column(
          children: <Widget>[
            HeaderRow(),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          _LeftWidget(),
                          _RightWidget(scrollController),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RightWidget extends StatelessWidget {
  final ScrollController scrollController;
  const _RightWidget(
    this.scrollController, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 566,
      height: 600,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Positioned(
              left: 18.0,
              top: 42.0,
              child: Container(
                width: 488,
                height: 499,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 10,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                  color: Color(0xfff9f9f9),
                ),
                child: Center(
                    child: HomePageCustomScroll(
                  controller: scrollController,
                )),
              ),
            ),
            Positioned(
              child: Container(
                height: 51,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x19000000),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                  color: const Color(0xff86b0f5),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 66,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Opacity(
                      opacity: 0.70,
                      child: Text(
                        "IP",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "8.8.8.8",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: ChatWithUs(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageCustomScroll extends StatelessWidget {
  const HomePageCustomScroll({Key key, @required this.controller})
      : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar(
      alwaysVisibleScrollThumb: true,
      controller: controller,
      child: ListView.builder(
        controller: controller,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Text(
            '''{
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
                        "active"''',
            style: GoogleFonts.poppins(
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 16.0,
              height: 2.0,
            ),
          );
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
            color: const Color(0xffffde8a),
          ),
        );
      },
    );
  }
}

class _LeftWidget extends StatelessWidget {
  const _LeftWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 442,
            child: Text(
              'The Trusted Source for IP Address Data',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 13),
          Container(
            width: 442.0,
            child: Text(
              '''With IPengine, you can pinpoint your users’ locations, customize their experiences, prevent fraud, ensure compliance, and so much more.''',
              style: GoogleFonts.poppins(
                color: const Color(0xff555555),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            r'$0.00 per month, We know it’s expensive!',
            style: GoogleFonts.poppins(
              color: const Color(0xfff0864b),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 34),
          Container(
            width: 156,
            height: 51,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              border: Border.all(
                color: Colors.black,
                width: 1.50,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x28000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
              color: Colors.white,
            ),
            child: FlatButton(
              child: Text(
                'Get Started',
                style: GoogleFonts.poppins(
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
