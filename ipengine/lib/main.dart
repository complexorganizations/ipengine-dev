import 'package:flutter/material.dart';
import 'package:ipengine/features/domain/entity/hide_myname_entity.dart';
import 'package:ipengine/features/presentation/pages/web/documentation_page_widget/Ipengine_info_page.dart';
import 'package:ipengine/features/presentation/pages/web/documentation_page_widget/contact_sales_page.dart';
import 'package:ipengine/features/presentation/pages/web/documentation_page_widget/hide_myname_page.dart';
import 'package:ipengine/features/presentation/pages/web/documentation_page_widget/security_trails_page.dart';
import 'package:ipengine/features/presentation/screens/home_screen.dart';
import 'package:ipengine/features/presentation/screens/login_screen.dart';

import 'features/presentation/pages/web/documentation_page_widget/ai_machine_learining_page.dart';
import 'features/presentation/pages/web/documentation_page_widget/reverse_ip_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IPengine',
      home: AiMachineLearningPage(),
    );
  }
}
