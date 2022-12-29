import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/helpers/constants.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/helpers/helper.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/company/companies.dart';
import 'package:flutter_study_app/home_tasks/home_task_29.12.2022/models/company/new_company.dart';
import 'package:http/http.dart';

class CompanyClient {
  static const _urlPostFix = '/flutter/v1/companies';

  Future<AllCompanies> fetchAllCompanies() async {
    final url = Uri.http(ipHost, _urlPostFix);
    var response = await get(url);
    if (response.statusCode != 200) {
      logger.e(
          'Request Failed to get $url data. Status code is ${response.statusCode}');
    }
    return AllCompanies.fromJson(response.body);
  }

  Future<void> addCompany(NewCompany company) async {
    var postCompany = Uri.http(ipHost, _urlPostFix);
    var header = {'Content-Type': 'application/json'};
    var resp = await post(postCompany, headers: header, body: company.toJson());
    if (resp.statusCode != 200) {
      throw Exception(
          'Request Failed to Add Company $company.\nResponse ${resp.body}');
    }
  }

  Future<void> deleteCompany(int id) async {
    var url = Uri.http(ipHost, '$_urlPostFix/$id');
    var response = await delete(url);
    if (response.statusCode != 200) {
      throw Exception(
          'Request Failed to delete Company by id $id.\nResponse ${response.body}');
    }
  }
}
