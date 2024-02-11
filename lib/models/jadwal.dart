class Jadwal {
  final DateTime tglKegiatan;
  final String jenisKegiatan;
  final String alamatLokasiKegiatan;
  final String tempatLokasiKegiatan;

  Jadwal(this.tglKegiatan, this.jenisKegiatan, this.alamatLokasiKegiatan,
      this.tempatLokasiKegiatan);
  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(DateTime.parse(json["tglKegiatan"]), json["jenisKegiatan"],
        json["alamatLokasiKegiatan"], json["tempatLokasiKegiatan"]);
  }
}
