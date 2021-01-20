import 'package:flutter/cupertino.dart';

class Currency {
  String id;
  String description;

  Currency({this.id, this.description});

  factory Currency.fromMap(String key, String value) {
    return Currency(
      id: key,
      description: value,
    );
  }
}