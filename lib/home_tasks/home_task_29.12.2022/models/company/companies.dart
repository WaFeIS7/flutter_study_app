import 'dart:convert';
import 'package:equatable/equatable.dart';

class AllCompanies extends Equatable{
  List<Company> result;

  AllCompanies({
    required this.result,
  });

  factory AllCompanies.fromMap(Map<String, dynamic> map) {
    return AllCompanies(
        result:
            List<Company>.from(map['result'].map((f) => Company.fromMap(f))));
  }

  factory AllCompanies.fromJson(String source) =>
      AllCompanies.fromMap(json.decode(source));

  @override
  String toString() => 'Compamies(result: $result)';

  @override
  List<Object?> get props => [result];
}

class Company extends Equatable {
  final int id;
  final String name;
  final String description;
  final String industry;

  const Company({
    required this.id,
    required this.name,
    required this.description,
    required this.industry,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'industry': industry,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      industry: map['industry'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CompanyResult(id: $id, name: $name, description: $description, industry: $industry)';
  }

  @override
  List<Object?> get props => [id, name, description, industry];
}
