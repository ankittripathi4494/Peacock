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
