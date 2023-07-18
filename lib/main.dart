import 'package:flutter/material.dart';
import 'package:restapi_flutter/Home_Screen.dart';
import 'package:restapi_flutter/RestAPI_Photo.dart';
import 'package:restapi_flutter/RestApi_User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:   UserApi(),
    );
  }
}
