import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/clients/company_client.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/company/new_company.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/helpers/widget_helper.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/company/companies.dart';
import 'details_company_screen.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  Future<AllCompanies>? _allCompanies;
  CompanyClient companyClient = CompanyClient();

  @override
  void initState() {
    super.initState();
    _allCompanies = CompanyClient().fetchAllCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          elevation: 0,
          title: const Text('All Companies'),
          backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.blueGrey,
            onPressed: (() {
              showDialog(
                  context: context,
                  builder: (context) {
                    final name = TextEditingController();
                    final description = TextEditingController();
                    final industry = TextEditingController();
                    return AlertDialog(
                      backgroundColor: Colors.blueGrey,
                      title: const Text('Add New Company'),
                      content: SizedBox(
                          width: 30,
                          height: 150,
                          child: ListView(
                            children: [
                              TextFormField(
                                controller: name,
                                decoration:
                                    const InputDecoration(hintText: 'Name'),
                              ),
                              TextFormField(
                                controller: description,
                                decoration: const InputDecoration(
                                    hintText: 'Description'),
                              ),
                              TextFormField(
                                controller: industry,
                                decoration:
                                    const InputDecoration(hintText: 'Industry'),
                              )
                            ],
                          )),
                      actions: [
                        TextButton(
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.white24)),
                            onPressed: () => Navigator.pop(context)),
                        TextButton(
                            onPressed: () {
                              companyClient.addCompany(NewCompany(
                                  name: name.text,
                                  description: description.text,
                                  industry: industry.text));

                              setState(() {
                                _allCompanies = companyClient.fetchAllCompanies();
                              });

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Success')));
                            },
                            child: const Text('Add',
                                style: TextStyle(color: Colors.white24))),
                      ],
                    );
                  });
            }),
            label: const Text('Add'),
            icon: const Icon(Icons.add)),
        body: FutureBuilder(
          future: _allCompanies,
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              showErrorConnection(snapshot);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            var companies = snapshot.data!.result;
            return _listCompanies(companies);
          },
        ));
  }

  ListView _listCompanies(List<Company> companies) {
    return ListView.builder(
        itemCount: companies.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white24)),
              leading: const Icon(Icons.numbers),
              title: Text(
                companies[index].name.capitalize(),
                style: const TextStyle(color: Color.fromARGB(255, 234, 178, 7)),
              ),
              subtitle: Text(
                  '${companies[index].description.capitalize()}\n${companies[index].industry}',
                  style: const TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsCompanyScreen(
                            companyResult: companies[index])));
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
                      companyClient.deleteCompany(companies[index].id);
                      setState(() {
                        _allCompanies = companyClient.fetchAllCompanies();
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
