import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/pages/mobile/pages/documentation_page_mobile.dart';
import 'package:ipengine/features/presentation/pages/mobile/pages/login_page_mobile.dart';
import 'package:ipengine/features/presentation/pages/tablet/pages/documentation_page_tablet.dart';
import 'package:ipengine/features/presentation/pages/web/pages/documentation_page_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DocumentationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // if (sizingInformation.isDesktop){
        //   return DocumentationPageWeb();
        // }
        // if (sizingInformation.isTablet){
        //   return DocumentationPageTablet();
        // }
        // return DocumentationPageMobile();
        return DocumentationPageWeb();
      },
    );
  }
}
