import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/pages/web/pages/login_page_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // if (sizingInformation.isDesktop){
        //   return LoginPageWeb();
        // }
        // if (sizingInformation.isTablet){
        //   return LoginPageTablet();
        // }
        // return LoginPageMobile();
        return LoginPageWeb();
      },
    );
  }
}
