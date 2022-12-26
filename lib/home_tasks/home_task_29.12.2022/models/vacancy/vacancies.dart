import 'dart:convert';

import 'package:equatable/equatable.dart';

class AllVacancies extends Equatable {
  final List<Vacancy> result;

  const AllVacancies({required this.result});

  factory AllVacancies.fromMap(Map<String, dynamic> map) {
    return AllVacancies(
        result:
            List<Vacancy>.from(map['result'].map((f) => Vacancy.fromMap(f))));
  }

  factory AllVacancies.fromJson(String sources) =>
      AllVacancies.fromMap(json.decode(sources));

  @override
  List<Object?> get props => [result];

  @override
  bool? get stringify => true;
}

class Vacancy extends Equatable {
  final int id;
  final int companyId;
  final String title;
  final String description;
  final String city;

  const Vacancy(
      {required this.id,
      required this.companyId,
      required this.title,
      required this.description,
      required this.city});

  factory Vacancy.fromMap(Map<String, dynamic> map) {
    return Vacancy(
        id: map['id'],
        companyId: map['companyId'],
        title: map['title'],
        description: map['description'],
        city: map['city']);
  }

  factory Vacancy.fromJson(String sources) =>
      Vacancy.fromMap(json.decode(sources));

  @override
  List<Object?> get props => [id, companyId, title, description, city];

  @override
  String toString() {
    return "JobResult(id: $id, companyId: $companyId, title: $title, description: $description, city: $city)";
  }
}
