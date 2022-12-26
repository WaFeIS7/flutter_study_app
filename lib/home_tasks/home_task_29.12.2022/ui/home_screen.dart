import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/helpers/widget_helper.dart';
import 'company/companies_screen.dart';
import 'vacancy/vacancies_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: appsBar('Companies and Vacancies'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 28.0,
                fontFamily: 'Horizon',
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Vacancies'),
                ],
                isRepeatingAnimation: true,
                onTap: () {
                  navigateToScreen(context, const VacanciesScreen());
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Companies',
                  textStyle: const TextStyle(
                    fontSize: 28.0,
                    fontFamily: 'Horizon',
                  ),
                  colors: [
                    Colors.blue,
                    Colors.yellow,
                  ],
                )
              ],
              onTap: () {
                navigateToScreen(context, const CompaniesScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
