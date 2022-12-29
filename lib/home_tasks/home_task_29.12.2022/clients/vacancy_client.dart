import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/helpers/constants.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/helpers/helper.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/vacancy/new_vacancy.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/vacancy/vacancies.dart';
import 'package:http/http.dart';

class VacancyClient {
  static const _urlPostFix = '/flutter/v1/jobs';

  Future<AllVacancies> fetchJobByCompanyId(int id) async {
    final url = Uri.http(ipHost, '/flutter/v1/companies/$id/jobs/');
    var response = await get(url);
    if (response.statusCode != 200) {
      logger.e(
          'Request Failed to get $url data. Status code is ${response.statusCode}');
    }
    return AllVacancies.fromJson(response.body);
  }

  Future<AllVacancies> fetchAllVacancies() async {
    final url = Uri.http('3.75.134.87', _urlPostFix);
    var response = await get(url);
    if (response.statusCode != 200) {
      logger.e(
          'Request Failed to get $url data. Status code is ${response.statusCode}');
    }
    return AllVacancies.fromJson(response.body);
  }

  Future<void> deleteVacancy(int id) async {
    final url = Uri.http(ipHost, '$_urlPostFix/$id');
    var response = await delete(url);
    if (response.statusCode != 200) {
      throw Exception(
          'Request Failed to delete Vacancy by id $id.\nResponse ${response.body}');
    }
  }

  Future<void> addVacancy(NewVacancy vacancy) async {
    final url = Uri.http(ipHost, _urlPostFix);
    var header = {'Content-Type': 'application/json'};
    var resp = await post(url, headers: header, body: vacancy.toJson());
    if (resp.statusCode != 200) {
      throw Exception(
          'Request Failed to Add Vacancy $vacancy.\nResponse ${resp.body}');
    }
  }
}
