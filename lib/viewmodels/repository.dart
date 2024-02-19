// login_view_model.dart
import 'package:absensi_elektronik/models/jadwal.dart';
import 'package:absensi_elektronik/models/kehadiran.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:absensi_elektronik/models/kehadiran.dart';

class LoginViewModel extends ChangeNotifier {
  String? token;
  String namaPegawai = "";
  String gelarblkg = "";
  String nip = "";
  String skpd = "";
  String satker = "";
  String bidang = "";
  bool loading = false;
  String latitudeLokasi = "";
  String langitudeLokasi = "";
  String kehadiranToday = "";
  String absenMasuk = "";
  double latitudeTersimpan = 0;
  double longitudeTersimpan = 0; 

//api login
  Future<void> login(username, password) async {
    loading = true;
    notifyListeners();

    try {
      final response = await http.get(
          Uri.parse(
            'https://fbip.pariamankota.go.id/restapiabsensi_v1/auth',
          ),
          headers: {
            'X-Username': username,
            'X-Password': password,
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(response.body);
        token = responseData['response']['token'];
        nip = username;
        // Simpan token ke shared preferences
        await saveToken(token!);
        
        getProfil(username, token);

      } else {
        print('Username dan ');
      }
    } catch (error) {
      print('Error during login: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    notifyListeners();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

//api profil
  Future<void> getProfil(NIP, token) async{
    final response = await http.get(Uri.parse('https://fbip.pariamankota.go.id/restapiabsensi_v1/dashboard-pegawai/data-pegawai?NIP=$NIP'),
    headers: {
      'X-Token' : token,
      'X-Username' : NIP,
    }
    );
    final jsonData = jsonDecode(response.body) as Map;
    namaPegawai = jsonData['namaPegawai'];
    gelarblkg = jsonData['gelarblkg'];
    skpd = jsonData['skpd'];  //tambahkan
    satker = jsonData['satker'];
    bidang = jsonData['bidang'];
    notifyListeners(); 
  }

//api koordinat
  Future<void> getKoordinat (token) async{
    final response = await http.get(Uri.parse('https://fbip.pariamankota.go.id/restapiabsensi_v1/dashboard-pegawai/titik-koordinat?NIP=$nip'),
     headers: {
      'X-Token' : token,
      'X-Username' : nip,
    }
    );
    
    final jsonData = jsonDecode(response.body) as Map;
    latitudeLokasi = jsonData['latitude_lokasi'].toString();
    langitudeLokasi = jsonData['langitude_lokasi'].toString(); 
    notifyListeners();
  }

//api jadwal
  Future<Jadwal> getJadwal() async{
    final tahun = DateTime.now().year;
    final bulan = DateTime.now().month;

    final response = await http.get(Uri.parse('https://fbip.pariamankota.go.id/restapiabsensi_v1/dashboard-pegawai/jadwal-kegiatan-perbulan?bulan=$bulan&tahun=$tahun'), //cara masukkin params di api
    headers: {
      'X-Token' : token!,
      'X-Username' : nip,
    }
    );
    final jsonData = jsonDecode(response.body) as Map;
    final jadwal = Jadwal.fromJson(jsonData["response_result"][0]);
    return jadwal;
  }

  //Api get kehadiran
  Future<void> getKehadiran() async {
    final response = await http.get(Uri.parse("https://fbip.pariamankota.go.id/restapiabsensi_v1/dashboard-pegawai/kehadiran-pegawai?NIP=$nip&X-Username=$nip"),
     headers: {
      'X-Token' : token!,
      'X-Username' : nip,
    }
    );
    final jsonData = jsonDecode(response.body) as Map;
    kehadiranToday = jsonData["kehadiran_today"];
    absenMasuk = jsonData["absen_masuk"];
    latitudeTersimpan = jsonData["latitude_tersimpan"];
    longitudeTersimpan = jsonData["longitude_tersimpan"];
    notifyListeners();
}

//Api Post absen masuk
Future<void> postAbsenmasuk(lat, long) async {
  final response = await http.post(Uri.parse("https://fbip.pariamankota.go.id/restapiabsensi_v1/dashboard-pegawai/absen-masuk"),
   headers: {
      'X-Token' : token!,
      'X-Username' : nip,
      "Content-Type": "application/json"
    },
  body: jsonEncode({
    "absen_nip": nip,
    "absen_lat": lat,
    "absen_lng": long,
    }),
  );
  print(response.body);
}
}
 