import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:novindus_machine_test/config/constants/app_routes.dart';
import 'package:novindus_machine_test/config/decoration/size_configs.dart';
import 'package:novindus_machine_test/presentation/appointments/screens/appointment_list_screen.dart';
import 'package:novindus_machine_test/presentation/appointments/screens/create_appointment_screen.dart';
import 'package:novindus_machine_test/presentation/appointments/viewmodel/appointment_viewmodel.dart';
import 'package:novindus_machine_test/presentation/onboarding/screens/login_screen.dart';
import 'package:novindus_machine_test/presentation/onboarding/screens/splash_screen.dart';
import 'package:novindus_machine_test/repositories/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppointmentViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      routes: {
        AppRoutes.splashScreen: (context) => SplashScreen(),
        AppRoutes.signIn: (context) => LoginScreen(),
        AppRoutes.appointmentList: (context) => AppointmentListScreen(),
        AppRoutes.createAppointment: (context) => CreateAppointmentScreen(),
      },
    );
  }
}
