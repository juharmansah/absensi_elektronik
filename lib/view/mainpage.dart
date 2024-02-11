import 'package:absensi_elektronik/view/absensi.dart';
import 'package:absensi_elektronik/view/homepage.dart';
import 'package:absensi_elektronik/view/profil.dart';
import 'package:flutter/material.dart';

import 'navbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List get _halaman => [
    Homepage(pindahHalaman: pindahHalaman),
    Absensi(),
    Profil(),
  ];

  void pindahHalaman(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _halaman[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
