import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/clients/company_client.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/clients/vacancy_client.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/company/companies.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/vacancy/vacancies.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/ui/vacancy/details_vacancies_screen.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/helpers/helper.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/helpers/widget_helper.dart';

class VacanciesScreen extends StatefulWidget {
  const VacanciesScreen({Key? key}) : super(key: key);

  @override
  State<VacanciesScreen> createState() => _VacanciesScreenState();
}

class _VacanciesScreenState extends State<VacanciesScreen> {
  Future<AllVacancies>? _allVacancies;
  Future<AllCompanies>? _allCompanies;

  VacancyClient vacancyClient = VacancyClient();
  CompanyClient companyClient = CompanyClient();
  Company? _selected;

  @override
  void initState() {
    super.initState();
    _allCompanies = companyClient.fetchAllCompanies();
    _allVacancies = vacancyClient.fetchAllVacancies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: appsBar('Vacancies'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                final title = TextEditingController();
                final description = TextEditingController();
                final city = TextEditingController();
                return AlertDialog(
                  backgroundColor: Colors.blueGrey,
                  title: const Text('Add New Vacancy'),
                  content: SizedBox(
                      width: 30,
                      height: 200,
                      child: ListView(
                        children: [
                          TextFormField(
                            controller: title,
                            decoration:
                                const InputDecoration(hintText: 'Title'),
                          ),
                          TextFormField(
                            controller: description,
                            decoration:
                                const InputDecoration(hintText: 'Description'),
                          ),
                          TextFormField(
                            controller: city,
                            decoration: const InputDecoration(hintText: 'City'),
                          ),
                          // _dropDown(),
                        ],
                      )),
                  actions: [
                    TextButton(
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.white24)),
                        onPressed: () => Navigator.pop(context)),
                    TextButton(
                        onPressed: () {
                          logger.i(
                              'Name: ${title.text} Description: ${description.text}, Industry: ${city.text}: ID company ${_selected?.id.toString()}: Name: ${_selected?.name}');
                          // vacancyClient.addVacancy(NewVacancy(
                          //       title: title.text,
                          //       description: description.text,
                          //       city: city.text,
                          //       companyId: _selected!.id));
                          //
                          //   logger.i(o.toString());
                          //
                          //   setState(() {
                          //     _allVacancies = vacancyClient.fetchAllVacancies();
                          //   });

                          Navigator.pop(context);
                        },
                        child: const Text('Add',
                            style: TextStyle(color: Colors.white24))),
                  ],
                );
              });
        },
        backgroundColor: Colors.blueGrey,
        label: const Text('Add'),
        icon: const Icon(Icons.person_add),
      ),
      body: FutureBuilder(
        future: _allVacancies,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            showErrorConnection(snapshot);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var jobs = snapshot.data!.result;
          return _listJobs(jobs);
        },
      ),
    );
  }

  // TODO - investigate work with init state.
  Widget _dropDown() {
    return FutureBuilder(
        future: _allCompanies,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.result;
            return DropdownButton<Company>(
              isExpanded: true,
              hint: const Text('Select Company'),
              items: data.map<DropdownMenuItem<Company>>((e) {
                return DropdownMenuItem<Company>(value: e, child: Text(e.name));
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selected = newValue;
                  logger.i('_selected: $_selected');
                });
              },
              value: _selected,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.hasError}');
          }
          logger.i('The End: $_selected');
          return const CircularProgressIndicator();
        });
  }

  ListView _listJobs(List<Vacancy> jobs) {
    return ListView.builder(
        itemCount: jobs.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white24)),
              leading: const Icon(Icons.numbers),
              title: Text(
                jobs[index].title.capitalize(),
                style: const TextStyle(color: Color.fromARGB(255, 234, 178, 7)),
              ),
              subtitle: Text(
                  '${jobs[index].description.capitalize()}\n${jobs[index].city}',
                  style: const TextStyle(color: Colors.white)),
              onTap: () {
                navigateToScreen(
                    context, DetailsVacancyScreen(vacancy: jobs[index]));
              },
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: (() {
                      vacancyClient.deleteVacancy(jobs[index].id);
                      setState(() {
                        _allVacancies = vacancyClient.fetchAllVacancies();
                      });
                    }),
                  ),
                  const SizedBox(width: 1),
                  const Icon(
                    Icons.navigate_next_sharp,
                    color: Color.fromARGB(255, 8, 190, 105),
                    size: 35,
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
