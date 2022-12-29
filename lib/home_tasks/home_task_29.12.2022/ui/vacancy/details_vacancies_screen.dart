import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/vacancy/vacancies.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/helpers/widget_helper.dart';

class DetailsVacancyScreen extends StatelessWidget {
  final Vacancy vacancy;

  const DetailsVacancyScreen({
    Key? key,
    required this.vacancy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: appsBar('Vacancy'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            details("Title", vacancy.title),
            const SizedBox(height: 10),
            details('Description', vacancy.description),
            const SizedBox(height: 10),
            details('City', vacancy.city),
            const SizedBox(height: 10),
            details('Salary', _getSalary())
          ],
        ),
      ),
    );
  }
}

String _getSalary() => '\$${Random().nextInt(5000)}';
