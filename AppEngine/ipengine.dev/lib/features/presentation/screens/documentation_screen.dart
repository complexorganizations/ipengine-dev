import 'package:flutter/material.dart';
import 'package:ipengine/features/presentation/pages/web/pages/documentation_page_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DocumentationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return DocumentationPageWeb();
      },
    );
  }
}
