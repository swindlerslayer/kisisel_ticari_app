import 'dart:convert';

import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Models/Harcamalar/gider.dart';
import 'package:kisisel_ticari_app/Models/Harcamalar/gider_liste.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';
import 'package:kisisel_ticari_app/URL/token.dart';
import 'package:http/http.dart' as http;

class GiderController extends GetxController {
  final _giderList = <GiderListe>[].obs;
  List<GiderListe>? get giderList => _giderList;
  set giderList(List<GiderListe>? value) => _giderList;

  Future<List<GiderListe>?> getGider(String kullaniciAdi, String parola) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    try {
      final response = await http.get(
        Uri.parse('$apilink/api/kitaplisteyeekle'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        giderList = giderListeFromJson(response.body);
        return giderList;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> giderEkleDuzenle(KullaniciGiris kullanici, Gider x) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullanici.kullaniciAdi,
        parola: kullanici.kullaniciAdi,
        loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/giderekleduzenle');

    try {
      var headers = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.accessToken}"
      };
      var badi = json.encode(x);
      final response = await client.post(url, headers: headers, body: badi);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
