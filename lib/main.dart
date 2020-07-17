import 'package:flutter/material.dart';

import 'package:flutter_don_salvatore/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DonSalvatore',
      home: HomePage(),
    );
  }
}
