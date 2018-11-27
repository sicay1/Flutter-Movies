import 'package:flutter/material.dart';
import 'pages/search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Movies",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SearchPage(title: "Flutter Movies"),
    );
  }
}
