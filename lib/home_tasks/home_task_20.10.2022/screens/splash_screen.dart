import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/home_tasks/home_task_20.10.2022/screens/constants.dart';
import 'package:flutter_study_app/home_tasks/home_task_20.10.2022/screens/login_screen.dart';
import 'package:flutter_study_app/home_tasks/home_task_20.10.2022/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  bool _remember = false;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/splash_icon.png'),
      durationInSeconds: 3,
      logoWidth: 100,
      navigator: _remember ? const WelcomeScreen() : const Login(),
      title: const Text(
        'This is My First Splash Screen',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: Colors.white70,
      loaderColor: Colors.red.shade400,
      gradientBackground: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.yellow,
            Colors.blue,
          ]),
      loadingText: const Text('It will take some seconds',
          style: TextStyle(fontSize: 12, color: Colors.black)),
    );
  }

  void _getUser() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getBool(Constants.rememberMe);
    if (value != null) {
      _remember = value;
    }
  }
}
