import 'package:absensi_elektronik/view/petunjuk.dart';
import 'package:absensi_elektronik/view/splash.dart';
import 'package:absensi_elektronik/view/tentangkami.dart';
import 'package:flutter/material.dart';
import 'package:absensi_elektronik/viewmodels/repository.dart';
import 'package:provider/provider.dart';
import 'package:absensi_elektronik/view/homepage.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  LoginViewModel get viewModel => context.watch<LoginViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            Image.asset(
              'assets/logo.png',
              height: 60,
            ),
            Text(
              'Absensi Elektronik',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/person.png',
                  height: 150,
                  width: 100,
                ),
                SizedBox(width: 20.0),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${viewModel.namaPegawai}, ${viewModel.gelarblkg},',
                      ),
                      SizedBox(height: 5),
                      Text(
                        "NIP: ${viewModel.nip}",
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${viewModel.skpd}",
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${viewModel.satker}",
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${viewModel.bidang}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40), // Spasi antara Row dan Container baru
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.help_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Petunjuk()),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      // Tambahkan aksi yang ingin Anda lakukan ketika teks ditekan
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Petunjuk()),
                      );
                    },
                    child: Text(
                      "Petunjuk Penggunaan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TentangKami()),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      // Tambahkan aksi yang ingin Anda lakukan ketika teks ditekan
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TentangKami()),
                      );
                    },
                    child: Text(
                      "Tentang Kami",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Splash()),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      // Tambahkan aksi yang ingin Anda lakukan ketika teks ditekan
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Splash()),
                      );
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
