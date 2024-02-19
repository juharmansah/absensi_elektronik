class Kehadiran {
  final String kehadiranToday;
  final String absenMasuk;
  final double latitudeTersimpan;
  final double longitudeTersimpan;

  Kehadiran(this.kehadiranToday, this.absenMasuk, this.latitudeTersimpan,
      this.longitudeTersimpan);
  factory Kehadiran.fromJson(Map<String, dynamic> json) {
    return Kehadiran(
      json["kehadiran_today"],
      json["absen_masuk"],
      json["latitude_tersimpan"],
      json["longitude_tersimpan"],
    );
  }
}
