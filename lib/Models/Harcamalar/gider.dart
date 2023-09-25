// To parse this JSON data, do
//
//     final gider = giderFromJson(jsonString);

import 'dart:convert';

Gider giderFromJson(String str) => Gider.fromJson(json.decode(str));

String giderToJson(Gider data) => json.encode(data.toJson());

class Gider {
  int? id;
  int? harcamaTutari;
  dynamic harcamaTarihi;
  String? harcamaAciklama;
  int? kullaniciId;
  int? harcamaHesabi;

  Gider({
    required this.id,
    required this.harcamaTutari,
    required this.harcamaTarihi,
    required this.harcamaAciklama,
    required this.kullaniciId,
    required this.harcamaHesabi,
  });

  factory Gider.fromJson(Map<String, dynamic> json) => Gider(
        id: json["ID"],
        harcamaTutari: json["HarcamaTutari"],
        harcamaTarihi: json["HarcamaTarihi"],
        harcamaAciklama: json["HarcamaAciklama"],
        kullaniciId: json["KullaniciID"],
        harcamaHesabi: json["HarcamaHesabi"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "HarcamaTutari": harcamaTutari,
        "HarcamaTarihi": harcamaTarihi,
        "HarcamaAciklama": harcamaAciklama,
        "KullaniciID": kullaniciId,
        "HarcamaHesabi": harcamaHesabi,
      };
}
