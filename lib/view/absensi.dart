import 'package:absensi_elektronik/models/jadwal.dart';
import 'package:absensi_elektronik/viewmodels/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Absensi extends StatefulWidget {
  const Absensi({Key? key}) : super(key: key);


  @override
  State<Absensi> createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {

  Jadwal ? jadwal;
  //fungsi
  void getJadwal() async{
    jadwal = await context.read<LoginViewModel>().getJadwal();
    setState(() {
      
    });
  }

  @override
  void initState() {
      getJadwal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    String formattedTime = "${now.hour}:${now.minute}:${now.second}";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
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
      body: Center(
        child: Column(
          children: [
            //waktu
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tanggal:',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Jam: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          formattedTime,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],

                ),
              ),
            ),
            //kehadiran
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Container(
                width: 1000,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                children: [
                  Text("Informasi jadwal kegiatan PHBN, Senam dan Wirid untuk bulan Januari"),
                  Text(jadwal?.jenisKegiatan ?? ""),
                  Text(jadwal != null ? DateFormat("EEEE, dd MMMM yyyy").format(jadwal!.tglKegiatan): ""),
                  Text(jadwal?.tempatLokasiKegiatan ?? ""),
                  Text(jadwal?.alamatLokasiKegiatan ?? ""),
                ],
                ),
              ),
              
            ),
            //simpan absensi kehadiran
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("data"),
                  Text("data"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
