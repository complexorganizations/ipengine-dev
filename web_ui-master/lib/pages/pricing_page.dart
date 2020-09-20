import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_ui/config/assets.dart';
import 'package:web_ui/widgets/centered_view.dart';
import 'package:web_ui/widgets/chat_with_us.dart';
import 'package:web_ui/widgets/header_row.dart';

class PricingPage extends StatelessWidget {
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
                          _RightWidget(),
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
  const _RightWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 470.0,
            width: 562.0,
            child: Image.asset(Assets.laptopGuy),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0, right: 8.0),
              child: ChatWithUs(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeftWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 450,
        height: 625,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 153,
              child: Container(
                width: 450,
                height: 472,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 1),
                  border: Border.all(
                    color: Color.fromRGBO(238, 238, 238, 1),
                    width: 3,
                  ),
                ),
              ),
            ),
            Container(
              width: 450,
              height: 162,
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
                color: const Color(0xffe8f1ff),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 31.0),
                child: Text(
                  r'$0.00 / Free',
                  style: GoogleFonts.poppins(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 24.0),
                ),
              ),
            ),
            Positioned(
              left: 70.0,
              top: 70.0,
              child: Container(
                width: 52,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xff000000),
                ),
              ),
            ),
            Positioned(
              top: 93.0,
              left: 64.0,
              child: Container(
                width: 350,
                child: Text(
                  'Can you imagine all these expensive services been served for free!?',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff555555),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180.0,
              left: 30.0,
              child: Container(
                height: 500,
                width: 400,
                child: ListView(
                  children: [
                    _buildGreyTile('Geolocation'),
                    _buildWhiteTile('Asn'),
                    _buildGreyTile('Abuse'),
                    _buildWhiteTile('Privacy Detection'),
                    _buildGreyTile('Hosted domains'),
                    _buildWhiteTile('Carrier'),
                    _buildGreyTile('Company'),
                    _buildWhiteTile('IP Ranges'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhiteTile(String title) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 34.0, top: 10.0),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: const Color(0xff555555),
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 17.0,
          ),
        ),
      ),
      width: 316,
      height: 47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
    );
  }

  Widget _buildGreyTile(String title) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 34.0, top: 10.0),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: const Color(0xff555555),
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 17.0,
          ),
        ),
      ),
      width: 316,
      height: 47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: const Color(0xfff9f9f9),
      ),
    );
  }
}
