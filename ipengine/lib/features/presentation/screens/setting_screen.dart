import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/pages/mobile/pages/setting_page_mobile.dart';
import 'package:ipengine/features/presentation/pages/tablet/pages/setting_page_tablet.dart';
import 'package:ipengine/features/presentation/pages/web/pages/setting_page_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // if (sizingInformation.isDesktop){
        //   return SettingPageWeb();
        // }
        // if (sizingInformation.isTablet){
        //   return SettingPagetablet();
        // }
        // return SettingPageMobile();
        return SettingPageWeb();
      },
    );
  }
}
