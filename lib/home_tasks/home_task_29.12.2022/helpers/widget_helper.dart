import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/vacancy/vacancies.dart';

const mainColor = Color.fromRGBO(58, 66, 86, 1.0);

AppBar appsBar(String title) {
  return AppBar(
    elevation: 1,
    title: Text(title),
    backgroundColor: mainColor,
  );
}

void navigateToScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void showErrorConnection(AsyncSnapshot<Object> snapshot) {
  [
    const Icon(
      Icons.error_outline,
      color: Colors.red,
      size: 60,
    ),
    Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text('Error: ${snapshot.error}'),
    ),
  ];
}

Center showLoadData() => const Center(child: Text("Loading Data"));

Widget details(String desc, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
        flex: 1,
        child: Text(
          desc.capitalize(),
          style: const TextStyle(fontSize: 18),
        ),
      ),
      const SizedBox(
        width: 6,
      ),
      const SizedBox(height: 20),
      Flexible(
        flex: 1,
        child: Text(value.capitalize(),
            style: const TextStyle(fontSize: 18, color: Colors.white)),
      ),
    ],
  );
}
