import 'package:flutter/material.dart';

class Petunjuk extends StatelessWidget {
  const Petunjuk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/logo.png",
              height: 300,
              width: 400,
            ),
          ),
     
          Text(
            "KOTA PARIAMAN",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft, // Set alignment ke kiri
            child: Padding(
              padding: EdgeInsets.only(left: 20.0), // Sesuaikan nilai padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cara Penggunaan Absensi Elektronik:", style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 10,),
                  Text("1. Tekan tombol mendapatkan titik koordinat ", style: TextStyle(fontSize: 17),
                  ), 
                  Text("2. Pastikan berada di radius 10 meter dari titik koordinat lokasi yang telah ditentukan", style: TextStyle(fontSize: 17),
                  ), 
                  Text("3. Tekan tombol selfie untuk membuktikan kehadiran di lokasi ", style: TextStyle(fontSize: 17),
                  ), 
                  Text("4. Tekan tombol submit untuk mengkonfirmasi kehadiran", style: TextStyle(fontSize: 17),
                  ), 
                  Text("5. Halaman absensi berisi bukti presensi dan informasi kegiatan", style: TextStyle(fontSize: 17),
                  ), 
                ],
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}
