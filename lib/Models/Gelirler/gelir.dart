// To parse this JSON data, do
//
//     final gelir = gelirFromJson(jsonString);

import 'dart:convert';

Gelir gelirFromJson(String str) => Gelir.fromJson(json.decode(str));

String gelirToJson(Gelir data) => json.encode(data.toJson());

class Gelir {
  int? id;
  int? gelirTutari;
  dynamic gelirTarihi;
  String? gelirAciklama;
  int? kullaniciId;
  int? gelirHesabi;

  Gelir({
    required this.id,
    required this.gelirTutari,
    required this.gelirTarihi,
    required this.gelirAciklama,
    required this.kullaniciId,
    required this.gelirHesabi,
  });

  factory Gelir.fromJson(Map<String, dynamic> json) => Gelir(
        id: json["ID"],
        gelirTutari: json["GelirTutari"],
        gelirTarihi: json["GelirTarihi"],
        gelirAciklama: json["GelirAciklama"],
        kullaniciId: json["KullaniciID"],
        gelirHesabi: json["GelirHesabi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "GelirTutari": gelirTutari,
        "GelirTarihi": gelirTarihi,
        "GelirAciklama": gelirAciklama,
        "KullaniciID": kullaniciId,
        "GelirHesabi": gelirHesabi,
      };
}
