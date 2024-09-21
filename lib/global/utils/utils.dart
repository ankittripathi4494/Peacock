// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

extension Context on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  Size get screenSize => MediaQuery.of(this).size;
}

List<Map<String, dynamic>> genderList = [
  {'title': "Male", "input": 1},
  {'title': "Female", "input": 2},
  {'title': "Transgender", "input": 3},
  {'title': "Other", "input": 4}
];

List<Map<String, dynamic>> marriageStatusList = [
  {'title': "Married", "input": 1},
  {'title': "Unmarried", "input": 2},
  {'title': "Divorecee", "input": 3},
  {'title': "Widowed", "input": 4}
];
extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
  bool isValidEmail() {
    return RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(this);
  }

  bool isValidContact() {
    return (length == 10) ? true : false;
  }

  String getInitials({int? limitTo}) {
    var buffer = StringBuffer();
    var split = this.split(' ');
    for (var i = 0; i < (limitTo ?? split.length); i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }

  String toSlug() {
    return this
        .trim()
        .toLowerCase()
        .replaceAll('%2', '_')
        .replaceAll(' ', '_')
        .replaceAll('%20', '_')
        .replaceAll('/', '_');
  }
}

