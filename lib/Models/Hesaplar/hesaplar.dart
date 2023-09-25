// To parse this JSON data, do
//
//     final hesaplar = hesaplarFromJson(jsonString);

import 'dart:convert';

List<Hesaplar> hesaplarFromJson(String str) =>
    List<Hesaplar>.from(json.decode(str).map((x) => Hesaplar.fromJson(x)));

String hesaplarToJson(List<Hesaplar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hesaplar {
  int id;
  String hesapAdi;
  String hesapTuru;
  int hesapBakiyesi;
  int kullaniciId;
  List<dynamic> harcamalar;
  List<dynamic> gelirler;
  dynamic kullanici;

  Hesaplar({
    required this.id,
    required this.hesapAdi,
    required this.hesapTuru,
    required this.hesapBakiyesi,
    required this.kullaniciId,
    required this.harcamalar,
    required this.gelirler,
    required this.kullanici,
  });

  factory Hesaplar.fromJson(Map<String, dynamic> json) => Hesaplar(
        id: json["ID"],
        hesapAdi: json["HesapAdi"],
        hesapTuru: json["HesapTuru"],
        hesapBakiyesi: json["HesapBakiyesi"],
        kullaniciId: json["KullaniciID"],
        harcamalar: List<dynamic>.from(json["Harcamalar"].map((x) => x)),
        gelirler: List<dynamic>.from(json["Gelirler"].map((x) => x)),
        kullanici: json["Kullanici"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "HesapAdi": hesapAdi,
        "HesapTuru": hesapTuru,
        "HesapBakiyesi": hesapBakiyesi,
        "KullaniciID": kullaniciId,
        "Harcamalar": List<dynamic>.from(harcamalar.map((x) => x)),
        "Gelirler": List<dynamic>.from(gelirler.map((x) => x)),
        "Kullanici": kullanici,
      };
}
