import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/pages/mobile/pages/home_page_mobile.dart';
import 'package:ipengine/features/presentation/pages/mobile/pages/login_page_mobile.dart';
import 'package:ipengine/features/presentation/pages/tablet/pages/home_page_tablet.dart';
import 'package:ipengine/features/presentation/pages/web/pages/home_page_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context,sizingInformation){
        // if (sizingInformation.isDesktop){
        //   print("desktop device");
        //   return HomePageWeb();
        // }
        // if (sizingInformation.isTablet){
        //   print("tablet device");
        //   return HomePageTablet();
        // }
        // return HomePageMobile();
        return HomePageWeb();

      },
    );
  }
}
