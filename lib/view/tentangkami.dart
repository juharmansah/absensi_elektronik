import 'package:flutter/material.dart';

class TentangKami extends StatelessWidget {
  const TentangKami({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/kominfo_logo.png",
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                Text(
                  "KOTA PARIAMAN",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Aplikasi elektronik berbasis mobile dikembangkan oleh Kominfo Kota Pariaman. Aplikasi ini dikembangkan bertujuan untuk menunjang efektivitas dalam kegiatan di ruang lingkup kota pariaman",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(height: 40 ),
                Text("Jl. lmam Bonjol No.44, Pariaman Tengah, Kota Pariaman, Sumatera Barat 25518, Cimparuh, Kec. Pariaman Tengah, Kota Pariaman, Sumatera Barat 25517"),
              
              ],
            ),
          ),
          Column(
            children: [
              Expanded(
                child: 
                SizedBox()
              ),
              Text("Copyright: 2024 Dinas Komunikasi dan Informatika Kota Pariaman",
                style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          )
        ],
      ),

    );
  }
}
