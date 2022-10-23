import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/home_tasks/home_task_20.10.2022/screens/login_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.network(
          'https://cdn0.iconfinder.com/data/icons/healthcare-medical-14/128/_Care_hospital_medicine_recovery_treatment_hand_heart-64.png'),
      durationInSeconds: 3,
      logoWidth: 100,
      navigator: const Login(),
      title: const Text("This is My First Splash Screen"),
      backgroundColor: Colors.white70,
      loaderColor: Colors.red.shade400,
      loadingText: const Text("It will take some seconds"),
    );
  }
}
