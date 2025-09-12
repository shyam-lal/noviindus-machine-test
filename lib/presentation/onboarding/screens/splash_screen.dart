import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novindus_machine_test/presentation/appointments/viewmodel/appointment_list_vm.dart';
import 'package:provider/provider.dart';
import 'package:novindus_machine_test/config/constants/app_routes.dart';
import 'package:novindus_machine_test/repositories/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    Future.delayed(const Duration(seconds: 2), () {
      _navigateToNextScreen();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isLoggedIn = AuthService().isLoggedIn();
      if (isLoggedIn) {
        context.read<AppointmentListViewModel>().fetchAppointments();
      }
    });
  }

  void _navigateToNextScreen() {
    final isLoggedIn = AuthService().isLoggedIn();
    final nextRoute = isLoggedIn ? AppRoutes.appointmentList : AppRoutes.signIn;

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(nextRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.5),
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: SvgPicture.asset('assets/images/logo.svg', height: 150),
          ),
        ],
      ),
    );
  }
}
