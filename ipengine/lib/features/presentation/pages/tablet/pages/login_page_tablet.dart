import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/pages/tablet/pages/home_page_tablet.dart';
import 'package:ipengine/features/presentation/pages/web/widgets/common.dart';
import 'package:ipengine/features/presentation/widgets/common.dart';
import 'package:ipengine/features/presentation/widgets/theme/style.dart';

class LoginPageTablet extends StatefulWidget {
  @override
  _LoginPageTabletState createState() => _LoginPageTabletState();
}

class _LoginPageTabletState extends State<LoginPageTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Image.asset(
                  'assets/left_lines.png',
                ),
              ),
              _centerWidget(),
              Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Image.asset(
                  'assets/right_lines.png',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _centerWidget() {
    return Container(
      width: 424,
      height: 517,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(color: colorBBBBBB, blurRadius: 4, spreadRadius: 3),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 29, left: 20),
            child: Text(
              "IPengine.dev",
              style: textStyle24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 20),
            child: Text(
              "Innovative Source for IP Address Data",
              style: textStyle12,
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            height: 149,
            child: Stack(
              children: [
                Positioned(
                    left: 0.0,
                    right: 0.0,
                    child: Image.asset('assets/inside_line.png')),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/inside_nodes.png')),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          _googleButtonWidget(),
          SizedBox(
            height: 30,
          ),
          _textWidget(),
        ],
      ),
    );
  }

  Widget _googleButtonWidget() {
    return InkWell(
      onTap: () {
        push(context: context, child: HomePageTablet());
      },
      child: Center(
        child: Container(
          width: 228,
          height: 52,
          decoration: BoxDecoration(
              border: Border.all(
                color: color555555,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/google_icon.png'),
              Text("Continue with Google")
            ],
          ),
        ),
      ),
    );
  }

  Widget _textWidget() {
    return Center(
      child: Column(
        children: [
          Text(
            "By signing in you accept our,",
            style: TextStyle(fontSize: 10, color: colorBBBBBB),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Terms of Service",
                style: TextStyle(
                    fontSize: 10,
                    color: colorBBBBBB,
                    decoration: TextDecoration.underline),
              ),
              Text(
                " & ",
                style: TextStyle(fontSize: 10, color: colorBBBBBB),
              ),
              Text(
                "Privacy Policy",
                style: TextStyle(
                    fontSize: 10,
                    color: colorBBBBBB,
                    decoration: TextDecoration.underline),
              ),
            ],
          )
        ],
      ),
    );
  }
}
