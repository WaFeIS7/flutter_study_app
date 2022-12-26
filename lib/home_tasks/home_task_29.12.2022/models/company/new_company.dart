import 'dart:convert';

import 'package:equatable/equatable.dart';

class NewCompany extends Equatable {
  final String name;
  final String description;
  final String industry;

  const NewCompany(
      {required this.name, required this.description, required this.industry});

  Map<String, dynamic> _toMap() {
    return {
      'name': name,
      'description': description,
      'industry': industry,
    };
  }

  String toJson() => json.encode(_toMap());

  @override
  List<Object?> get props => [name, description, industry];
}
