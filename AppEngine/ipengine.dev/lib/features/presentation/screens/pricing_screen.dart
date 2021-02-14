import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/pages/web/pages/pricing_page_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PricingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return PricingPageWeb();
      },
    );
  }
}
