import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //border appbar
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        //pasang logo kota pariaman
        backgroundColor: Color(0xFF61F882),
        title: Row(
          children: [
            Image.asset('assets/logo.png',height: 60,),
            Text(
              'Absensi Elektronik',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
  
}
