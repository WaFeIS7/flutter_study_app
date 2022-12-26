import 'dart:math';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/clients/vacancy_client.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/company/companies.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/helpers/widget_helper.dart';

import '../../models/vacancy/vacancies.dart';

class DetailsCompanyScreen extends StatefulWidget {
  final Company companyResult;

  const DetailsCompanyScreen({
    Key? key,
    required this.companyResult,
  }) : super(key: key);

  @override
  State<DetailsCompanyScreen> createState() => _DetailsCompanyScreenState();
}

class _DetailsCompanyScreenState extends State<DetailsCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        appBar: appsBar('Details Company'),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    details('Name', widget.companyResult.name),
                    const SizedBox(height: 10),
                    details('Description', widget.companyResult.description),
                    const SizedBox(height: 10),
                    details('Industry', widget.companyResult.industry),
                    const SizedBox(height: 10),
                    details('Raiting', ''),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getReviews(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                    future: VacancyClient()
                        .fetchJobByCompanyId(widget.companyResult.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        showErrorConnection(snapshot);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      var jobs = snapshot.data!.result;
                      return jobs.isEmpty
                          ? _noAvailableJobs()
                          : _listJobs(jobs);
                    })
              ],
            ),
          ),
        ));
  }

  Widget _noAvailableJobs() {
    return const Text(
      'No Available Vacancies',
      style: TextStyle(fontSize: 18),
    );
  }

  List<Widget> _getReviews() {
    return List<Widget>.generate(
      Random().nextInt(5) + 1,
      (int index) {
        return const Icon(Icons.star, color: Color.fromARGB(255, 247, 215, 4));
      },
    );
  }
}

ListView _listJobs(List<Vacancy> jobs) {
  return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: const Icon(Icons.accessibility_outlined),
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white24)),
            title: Text(
              jobs[index].title.capitalize(),
              style: const TextStyle(color: Color.fromARGB(255, 234, 178, 7)),
            ),
            subtitle: Text(
                '${jobs[index].description.capitalize()}\n${jobs[index].city}',
                style: const TextStyle(color: Colors.white)),
          ),
        );
      });
}
