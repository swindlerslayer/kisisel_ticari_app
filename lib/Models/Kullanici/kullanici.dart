/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
import 'package:get/get.dart';

class KullaniciController {
  final _value = ''.obs;
  String get value => _value.value;
  set value(String value) => _value.value = value;
}

class KullaniciGiris {
  int? id;
  String? kullaniciAdi;
  String? parola;
  String? kayitYapan;
  String? kayitTarihi;
  String? degisiklikYapan;
  String? degisiklikTarihi;
  dynamic resim1;

  KullaniciGiris(
      {this.id,
      this.parola,
      this.kullaniciAdi,
      this.kayitYapan,
      this.kayitTarihi,
      this.degisiklikYapan,
      this.degisiklikTarihi,
      this.resim1});

  factory KullaniciGiris.fromJson(Map<String, dynamic> json) => KullaniciGiris(
      id: json['ID'],
      kullaniciAdi: json['KullaniciAdi'],
      parola: json['Parola'],
      kayitYapan: json['KayitYapan'],
      kayitTarihi: json['KayitTarihi'],
      degisiklikYapan: json['DegisiklikYapan'],
      degisiklikTarihi: json['DegisiklikTarihi'],
      resim1: json['Resim1']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ID'] = id;
    data['KullaniciAdi'] = kullaniciAdi;
    data['Parola'] = parola;
    data['KayitYapan'] = kayitYapan;
    data['KayitTarihi'] = kayitTarihi;
    data['DegisiklikYapan'] = degisiklikYapan;
    data['DegisiklikTarihi'] = degisiklikTarihi;
    data['Resim1'] = resim1;
    return data;
  }
}
