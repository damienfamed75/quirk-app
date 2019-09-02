import 'package:flutter/material.dart';

import 'predicatelist.dart';

void main() => runApp(TestingApp());

class TestingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PredicateList());
  }
}