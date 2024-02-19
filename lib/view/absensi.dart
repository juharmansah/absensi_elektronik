import 'package:absensi_elektronik/models/jadwal.dart';
import 'package:absensi_elektronik/viewmodels/repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:absensi_elektronik/models/kehadiran.dart';

class Absensi extends StatefulWidget {
  const Absensi({Key? key}) : super(key: key);

  @override
  State<Absensi> createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
  Jadwal? jadwal;
  Kehadiran? kehadiran;
  //fungsi
  void getData() async {
    jadwal = await context.read<LoginViewModel>().getJadwal();
    context.read<LoginViewModel>().getKehadiran();
    setState(() {});
  }

  @override
  void initState() {
    getData();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            //waktu
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.access_time_filled,
                    size: 40,
                  ),
                  Text(
                    'Tanggal:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Jam:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    formattedTime,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Kehadiran", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("${context.watch<LoginViewModel>().kehadiranToday}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Absen Masuk",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("${context.watch<LoginViewModel>().absenMasuk}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Latitude Tersimpan",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("${context.watch<LoginViewModel>().latitudeTersimpan}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Longitude Tersimpan", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("${context.watch<LoginViewModel>().longitudeTersimpan}"),
                ],
              ),
            ),

            SizedBox(height: 10),
            //kehadiran
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Container(
                  padding: EdgeInsets.all(6),
                  width: 1000,
                  height: 260,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Wrap the icon in an Expanded widget to make it flexible
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.access_alarm_outlined,
                              size: 40,
                            ),
                          ),
                          // Use Expanded for the text as well to take remaining space
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Informasi jadwal kegiatan PHBN, Senam dan Wirid",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      //jarak alamat

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.all(20)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Deskripsi Kegiatan:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(
                        "Jenis Kegiatan :   ${jadwal?.jenisKegiatan ?? ""}",
                      ),
                      Text(
                          "Waktu                :   ${jadwal != null ? DateFormat("EEEE, dd MMMM yyyy").format(jadwal!.tglKegiatan) : ""}"),
                      Text(
                        "Lokasi                :   ${jadwal?.tempatLokasiKegiatan ?? ""}",
                      ),
                      Text(
                          "Alamat               :   ${jadwal?.alamatLokasiKegiatan ?? ""}"),
                    ],
                  ),
                ),
              ),
            ),
            //simpan absensi kehadiran
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
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

// Text('${viewModel.namaPegawai}, ${viewModel.gelarblkg},',
//                       ),
