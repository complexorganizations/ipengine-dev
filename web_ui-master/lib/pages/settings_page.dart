import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_ui/config/assets.dart';
import 'package:web_ui/widgets/centered_view.dart';
import 'package:web_ui/widgets/chat_with_us.dart';
import 'package:web_ui/widgets/header_row.dart';

class SettingsPage extends StatelessWidget {
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
                  Column(
                    children: [
                      Row(
                        children: [
                          _LeftWidget(),
                          SizedBox(width: 142.0),
                          Container(
                            width: 1,
                            height: 627,
                            decoration: BoxDecoration(
                              color: const Color(0xffdddddd),
                            ),
                          ),
                          _RightWidget()
                        ],
                      )
                    ],
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
      flex: 3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 300.0),
            child: _buildSettingsText('API Key', isBlack: false),
          ),
          Container(
            width: 365,
            height: 41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xffdddddd), width: 1),
              color: const Color(0xfff5f5f5),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: SelectableText(
                  "ifadp-f9uef-89nuq-wgerh-ic41n-123e4-1423n",
                  style: const TextStyle(
                      color: const Color(0xff555555),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 84.0),
          Padding(
            padding: const EdgeInsets.only(right: 300.0),
            child: _buildSettingsText('Settings', isBlack: false),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 11.0),
            child: _buildSettingTile('Edit Profile'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: _buildSettingTile('App Theme', isTheme: true),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: _buildSettingTile('Change Owner'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: _buildSettingTile('Temporarily Deactive Account'),
          ),
          SizedBox(height: 50),
          Align(
            alignment: Alignment.bottomRight,
            child: ChatWithUs(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(String tileText, {isTheme = false}) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: 358,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xffeeeeee), width: 1),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x1a000000),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: 0)
              ],
              color: const Color(0xfffafafa),
            ),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: _buildSettingsText(tileText),
                  ),
                ),
                Spacer(),
                isTheme
                    ? Padding(
                        padding: const EdgeInsets.only(right: 17.0),
                        child: InkWell(
                          onTap: () {},
                          child: Image.asset(Assets.themeSwitch),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text _buildSettingsText(String text, {bool isBlack = true}) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: isBlack ? const Color(0xff000000) : const Color(0xff999999),
        fontWeight: isBlack ? FontWeight.w500 : FontWeight.w600,
        fontStyle: FontStyle.normal,
        fontSize: isBlack ? 14.0 : 12.0,
      ),
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
        children: [
          Container(
            width: 184,
            height: 184,
            child: Image.asset(
              Assets.largeAvatar,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 35.0),
          _buildLeftProfileText(
            text: 'Meliodas Ackerman',
            fontWeight: FontWeight.w600,
            color: const Color(0xff000000),
            fontSize: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70.0),
            child: _buildLeftProfileText(
              text: 'dragons.sin@gmail.com',
              fontWeight: FontWeight.w400,
              color: const Color(0xff555555),
              fontSize: 14.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: _buildLeftProfileText(
              text: 'Your IP',
              fontWeight: FontWeight.w600,
              color: const Color(0xffbbbbbb),
              fontSize: 12.0,
            ),
          ),
          _buildLeftProfileText(
            text: '192.24.84.123',
            fontWeight: FontWeight.w600,
            color: const Color(0xfffbbc05),
            fontSize: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: _buildLeftProfileButton(
              buttonText: 'Feedback',
              width: 174,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: _buildLeftProfileButton(
              buttonText: 'Logout',
              width: 134,
              isLogout: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftProfileButton({
    @required String buttonText,
    @required double width,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: width,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 0)
          ],
          color: const Color(0xffffffff),
        ),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 19.0),
              isLogout
                  ? Image.asset(Assets.logOut)
                  : Image.asset(Assets.feedback),
              SizedBox(width: 17.0),
              _buildLeftProfileText(
                text: buttonText,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: isLogout ? Color(0xffff3333) : Color(0xff555555),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildLeftProfileText({
    @required String text,
    @required FontWeight fontWeight,
    @required Color color,
    @required double fontSize,
  }) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontWeight: fontWeight,
        fontStyle: FontStyle.normal,
        fontSize: fontSize,
      ),
    );
  }
}
