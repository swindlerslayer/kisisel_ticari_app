// To parse this JSON data, do
//
//     final gelirListe = gelirListeFromJson(jsonString);

import 'dart:convert';

List<GelirListe> gelirListeFromJson(String str) => List<GelirListe>.from(json.decode(str).map((x) => GelirListe.fromJson(x)));

String gelirListeToJson(List<GelirListe> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GelirListe {
    int id;
    int gelirTutari;
    dynamic gelirTarihi;
    String gelirAciklama;
    int kullaniciId;
    int gelirHesabi;
    dynamic hesaplar;

    GelirListe({
        required this.id,
        required this.gelirTutari,
        required this.gelirTarihi,
        required this.gelirAciklama,
        required this.kullaniciId,
        required this.gelirHesabi,
        required this.hesaplar,
    });

    factory GelirListe.fromJson(Map<String, dynamic> json) => GelirListe(
        id: json["ID"],
        gelirTutari: json["GelirTutari"],
        gelirTarihi: json["GelirTarihi"],
        gelirAciklama: json["GelirAciklama"],
        kullaniciId: json["KullaniciID"],
        gelirHesabi: json["GelirHesabi"],
        hesaplar: json["Hesaplar"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "GelirTutari": gelirTutari,
        "GelirTarihi": gelirTarihi,
        "GelirAciklama": gelirAciklama,
        "KullaniciID": kullaniciId,
        "GelirHesabi": gelirHesabi,
        "Hesaplar": hesaplar,
    };
}
