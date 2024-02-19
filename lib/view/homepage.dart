import 'dart:io';
import 'package:absensi_elektronik/viewmodels/repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'dart:math' show cos, sqrt, asin;

class Homepage extends StatefulWidget {
  final Function(int index) pindahHalaman;
  const Homepage({Key? key, required this.pindahHalaman}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  LoginViewModel get viewModel => context.watch<LoginViewModel>();
  String? imagePath;
  double _latUser = 0.0;
  double _longUser = 0.0;

  Future getLokasiUser() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    // Perizinan
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Update lokasi
    locationData = await location.getLocation();
    _latUser = locationData.latitude!;
    _longUser = locationData.longitude!;
    setState(() {});
  }

  //hitung jaraknya
  double hitungJarak() {
    final latkantor = context.read<LoginViewModel>().latitudeLokasi;
    final langkantor = context.read<LoginViewModel>().langitudeLokasi;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((_latUser - double.parse(latkantor)) * p) / 2 +
        c(double.parse(latkantor) * p) *
            c(_latUser * p) *
            (1 - c((_longUser - double.parse(langkantor)) * p)) /
            2;
    return (12742 * asin(sqrt(a))) * 1000;
  }

//image picture
  Future<void> takePicture() async {
    try {
      XFile? takenImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imagePath = takenImage?.path;
      });
    } catch (e) {
      print('Error while taking picture: $e');
    }
  }

  void getLokasi() async {
    final token = await context.read<LoginViewModel>().getToken();
    context.read<LoginViewModel>().getKoordinat(token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLokasiUser();
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        
                //kontainer 1 titik koordinat
                child: Container(
                  width: 1000,
                  height: 230,
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/maps.jpg',
                          width: 50,
                          height: 50,
                        ),
                        Text(
                          'Titik Koordinat Lokasi',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
        
                        //latlong lokasi kantor
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Latitude",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Longitude",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(viewModel.latitudeLokasi),
                              Text(viewModel.langitudeLokasi),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            getLokasi();
                            // Aksi yang ingin dilakukan saat tombol ditekan
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 66, 164,
                                244), // Warna latar belakang tombol
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Klik untuk mendapatkan titik koordinat',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
        
                        //atur nanti output latlongnya lokasi kita
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Latitude",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Longitude",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_latUser.toString()),
                              Text(_longUser.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0), // Spacer antara kedua container
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
        
                //kontainer 2
                child: Container(
                  width: 1000,
                  // height: 230,
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
                      Image.asset(
                        'assets/person.png',
                        height: 80,
                        width: 80,
                      ),
        
                      Text(
                        '${viewModel.namaPegawai},${viewModel.gelarblkg}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "NIP: ${viewModel.nip}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Text(
                        "Sebelum klik tombol masuk, silahkan upload swafoto terlebih dahulu ketika sudah berada di sekitaran lokasi pengambilan absen",
                        textAlign: TextAlign.center,
                      ),
        
                      // Ganti ElevatedButton dengan RaisedButton untuk memberikan warna yang sama seperti pada file picker
                      ElevatedButton(
                        onPressed: takePicture,
                        child: Text(
                          "Ambil Foto",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Warna latar belakang tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Atur nilai border radius sesuai keinginan
                          ),
                        ),
                      ),
        
                      if (imagePath != null)
                        Text(
                          "foto Selfie berhasil diambil",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  // buttonn untuk upload databasenya
                  if (hitungJarak() <= 10) {
                    if (imagePath != null) {
                      await context.read<LoginViewModel>().postAbsenmasuk(_latUser, _longUser);
                      widget.pindahHalaman(1);
                    } else {
                      print("foto belum diambil");
                    }
                  } else {
                    print("jarak melebihi 10 meter");
                  }
                },
                child: Text("submit"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Warna latar belakang tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(150, 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Fungsi untuk menampilkan AlertDialog
// void _showAlertDialog(String message) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Info"),
//         content: Text(message),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Menutup dialog
//             },
//             child: Text("OK"),
//           ),
//         ],
// //       );
//     },
//   );
}
// }
