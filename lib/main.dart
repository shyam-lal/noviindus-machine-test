import 'package:flutter/material.dart';
import 'package:novindus_machine_test/config/constants/app_routes.dart';
import 'package:novindus_machine_test/config/decoration/size_configs.dart';
import 'package:novindus_machine_test/presentation/appointments/screens/appointment_list_screen.dart';
import 'package:novindus_machine_test/presentation/onboarding/screens/login_screen.dart';
import 'package:novindus_machine_test/repositories/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          AuthService().isLoggedIn()
              ? AppRoutes.appointmentList
              : AppRoutes.signIn,
      routes: {
        AppRoutes.signIn: (context) => LoginScreen(),
        AppRoutes.appointmentList: (context) => AppointmentListScreen(),
      },
    );
  }
}
