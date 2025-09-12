import 'package:flutter/material.dart';
import 'package:novindus_machine_test/config/constants/app_routes.dart';
import 'package:novindus_machine_test/config/decoration/size_configs.dart';
import 'package:novindus_machine_test/presentation/onboarding/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.signIn,
      routes: {
        AppRoutes.signIn: (context) => LoginScreen(),
      },
    );
  }
}