// SmartRide - Program Pemesanan Transportasi Sederhana
// Dibuat dengan konsep OOP (Abstraksi, Inheritance, Enkapsulasi, Polimorfisme)

abstract class Transportasi {
  String id;
  String nama;
  double _tarifDasar; // private
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

  double get tarifDasar => _tarifDasar; // enkapsulasi

  double hitungTarif(int jumlahPenumpang);

  void tampilInfo() {
    print('ID: ' + id);
    print('Nama: ' + nama);
    print('Tarif Dasar: Rp${_tarifDasar.toStringAsFixed(0)}');
    print('Kapasitas: $kapasitas');
  }
}

class Taksi extends Transportasi {
  double jarak;
  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
      : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return tarifDasar * jarak;
  }
}

class Bus extends Transportasi {
  bool adaWifi;
  Bus(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
      : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return (tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);
  }
}

class Pesawat extends Transportasi {
  String kelas;
  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelas)
      : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    double faktor = (kelas == 'Bisnis') ? 1.5 : 1.0;
    return tarifDasar * jumlahPenumpang * faktor;
  }
}

class Pemesanan {
  String idPemesanan;
  String namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(this.idPemesanan, this.namaPelanggan, this.transportasi,
      this.jumlahPenumpang, this.totalTarif);

  void cetakStruk() {
    print('===============================');
    print('ID Pemesanan: $idPemesanan');
    print('Nama: $namaPelanggan');
    print('Transportasi: ${transportasi.nama}');
    print('Jumlah Penumpang: $jumlahPenumpang');
    print('Total Bayar: Rp${totalTarif.toStringAsFixed(0)}');
    print('===============================');
  }
}

Pemesanan buatPemesanan(
    Transportasi t, String nama, int jumlahPenumpang, String idPemesanan) {
  double total = t.hitungTarif(jumlahPenumpang);
  return Pemesanan(idPemesanan, nama, t, jumlahPenumpang, total);
}

void tampilSemuaPemesanan(List<Pemesanan> daftar) {
  print('\\nDaftar Pemesanan:');
  for (var p in daftar) {
    p.cetakStruk();
  }
}

void main() {
  var taksi = Taksi('T001', 'GoTaxi', 3000, 4, 10);
  var bus = Bus('B001', 'Bus Trans', 15000, 30, true);
  var pesawat = Pesawat('P001', 'Garuda', 500000, 150, 'Bisnis');

  var daftar = <Pemesanan>[];

  var p1 = buatPemesanan(taksi, 'Rizqullah', 2, 'PSN01');
  var p2 = buatPemesanan(bus, 'Siti', 3, 'PSN02');
  var p3 = buatPemesanan(pesawat, 'Budi', 1, 'PSN03');

  daftar.addAll([p1, p2, p3]);
  tampilSemuaPemesanan(daftar);
}
