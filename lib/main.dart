import 'package:app_http_users_with_pagination_infinite_scrolling/page/home-page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Usuarios',
      theme: ThemeData(
     
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(),
    );
  }
}
