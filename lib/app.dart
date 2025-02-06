import 'package:applylog/app_constants.dart';
import 'package:applylog/display_applications_screen.dart';
import 'package:applylog/log_application_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApplyLog',
      theme: AppConstants.themeData,
      initialRoute: '/displayapplicationsScreen',
      routes: {
        '/displayapplicationsScreen': (context) =>
            const DisplayApplicationsScreen(),
        '/logapplicationScreen': (context) => const LogApplicationScreen(),
      },
    );
  }
}
