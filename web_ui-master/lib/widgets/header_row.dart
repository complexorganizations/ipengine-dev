import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_ui/pages/documentaion_page.dart';
import 'package:web_ui/pages/home_page.dart';
import 'package:web_ui/pages/pricing_page.dart';

import '../config/assets.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'IPengine.dev\n',
                  style: GoogleFonts.montserrat(
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 24.0,
                  ),
                ),
                TextSpan(
                  text: 'Innovative Source for IP Address Data',
                  style: GoogleFonts.poppins(
                      color: const Color(0xff999999),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
        Spacer(
          flex: 18,
        ),
        _buildColumnHeaderText(
          'Home',
          Icon(
            Icons.location_on_outlined,
            color: const Color(0xffF0864B),
          ),
          HomePage(),
          context,
        ),
        Spacer(),
        _buildHeaderText(
          'Pricing',
          PricingPage(),
          context,
        ),
        Spacer(),
        _buildHeaderText(
          'Documentaion',
          DocumentaionPage(),
          context,
        ),
        Spacer(),
        InkWell(
          onTap: () {},
          child: Container(
            height: 72,
            width: 45,
            child: Image.asset(Assets.avatar),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildHeaderText(
    String text,
    Widget widget,
    BuildContext context, {
    bool isTitle = false,
  }) {
    return InkWell(
      onTap: () => _goToNextPage(context, widget),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          color: isTitle ? const Color(0xff000000) : const Color(0xff555555),
          fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: isTitle ? 24.0 : 16.0,
        ),
      ),
    );
  }

  Widget _buildColumnHeaderText(
    String text,
    Widget child,
    Widget widget,
    BuildContext context,
  ) {
    return Column(
      children: [
        child,
        Padding(
          padding: const EdgeInsets.only(
            bottom: 24.0,
          ),
          child: _buildHeaderText(text, widget, context),
        ),
      ],
    );
  }

  void _goToNextPage(BuildContext context, Widget widget) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
