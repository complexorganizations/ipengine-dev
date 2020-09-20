import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              child: WebsafeSvg.asset(
                'assets/svg/login_page.svg',
              ),
            ),
            Positioned(
              bottom: 205,
              child: Opacity(
                opacity: 0.0,
                child: SizedBox(
                  height: 60,
                  width: 170,
                  child: RaisedButton(
                    onPressed: () {},
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
