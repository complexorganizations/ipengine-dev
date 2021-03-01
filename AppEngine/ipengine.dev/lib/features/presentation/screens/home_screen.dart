import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/pages/web/pages/home_page_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return HomePageWeb();
      },
    );
  }
}