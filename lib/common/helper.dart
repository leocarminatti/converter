
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dateFormat(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

Color generateRandomColor() {
  Random random = Random();

  return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256));
}

void displaySnackBar(BuildContext context, {@required String error}) {
  final snackBar = SnackBar(content: Text(error));
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(snackBar);
}