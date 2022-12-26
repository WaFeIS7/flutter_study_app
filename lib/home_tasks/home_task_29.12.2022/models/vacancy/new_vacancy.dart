import 'dart:convert';

import 'package:equatable/equatable.dart';

class NewVacancy extends Equatable {
  final String title;
  final String description;
  final String city;
  final int companyId;

  const NewVacancy({
    required this.title,
    required this.description,
    required this.city,
    required this.companyId,
  });

  Map<String, dynamic> _toMap() {
    return {
      'title': title,
      'description': description,
      'String': city,
      'companyId': companyId
    };
  }

  String toJson() => json.encode(_toMap());

  @override
  List<Object?> get props => [title, description, city, companyId];

  @override
  String toString() {
    return "JobResult(companyId: $companyId, title: $title, description: $description, city: $city)";
  }
}
