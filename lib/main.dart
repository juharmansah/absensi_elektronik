import 'dart:io';
import 'package:absensi_elektronik/view/profil.dart';
import 'package:absensi_elektronik/view/homepage.dart';
import 'package:absensi_elektronik/view/mainpage.dart';
import 'package:absensi_elektronik/view/splash.dart';
import 'package:absensi_elektronik/viewmodels/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/login.dart';
import 'view/profil.dart'; // Import file appbar.dart
// Import file home.dart

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => LoginViewModel(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/location': (context) => Profil(),
          '/navbar': (context) => MainPage(),
          '/login': (context) => LoginView(),
        },
      ),
    );
  }
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
