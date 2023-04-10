import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackthehike/Screens/cautions_screen.dart';
import 'package:hackthehike/Screens/home_screen.dart';
import 'package:hackthehike/Screens/login_screen.dart';
import 'package:hackthehike/Screens/onboarding_screen.dart';
import 'package:hackthehike/Screens/qr_code_screen.dart';
import 'package:hackthehike/bottom_navigation.dart';
import 'package:hackthehike/controllers/session_controller.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'Screens/splash_screen.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  ).whenComplete(() => debugPrint("Firebase Initialized"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
// Define a widget
    Widget firstWidget;

// Assign widget based on availability of currentUser
    if (firebaseUser != null) {
      firstWidget = const BottomNavigationScreen(title: "Home");
    } else {
      firstWidget = const LoginScreen();
    }
    return GetMaterialApp(
      title: 'hackthehike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          // textTheme: TextTheme(
          //     titleLarge: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),
          //     titleMedium: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 30,color: Colors.black),
          //     titleSmall: GoogleFonts.openSans(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.white),
          //
          //     labelSmall: GoogleFonts.openSans(fontWeight: FontWeight.normal,fontSize: 14,color: Colors.white),
          //     labelMedium: GoogleFonts.openSans(fontWeight: FontWeight.normal,fontSize: 13,color: Colors.black)
          // )
      ),
      home:  firstWidget,
    );
  }
}


