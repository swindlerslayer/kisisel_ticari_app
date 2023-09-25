// To parse this JSON data, do
//
//     final giderListe = giderListeFromJson(jsonString);

import 'dart:convert';

List<GiderListe> giderListeFromJson(String str) =>
    List<GiderListe>.from(json.decode(str).map((x) => GiderListe.fromJson(x)));

String giderListeToJson(List<GiderListe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GiderListe {
  int id;
  int harcamaTutari;
  dynamic harcamaTarihi;
  String harcamaAciklama;
  int kullaniciId;
  int harcamaHesabi;
  dynamic hesaplar;

  GiderListe({
    required this.id,
    required this.harcamaTutari,
    required this.harcamaTarihi,
    required this.harcamaAciklama,
    required this.kullaniciId,
    required this.harcamaHesabi,
    required this.hesaplar,
  });

  factory GiderListe.fromJson(Map<String, dynamic> json) => GiderListe(
        id: json["ID"],
        harcamaTutari: json["HarcamaTutari"],
        harcamaTarihi: json["HarcamaTarihi"],
        harcamaAciklama: json["HarcamaAciklama"],
        kullaniciId: json["KullaniciID"],
        harcamaHesabi: json["HarcamaHesabi"],
        hesaplar: json["Hesaplar"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "HarcamaTutari": harcamaTutari,
        "HarcamaTarihi": harcamaTarihi,
        "HarcamaAciklama": harcamaAciklama,
        "KullaniciID": kullaniciId,
        "HarcamaHesabi": harcamaHesabi,
        "Hesaplar": hesaplar,
      };
}
