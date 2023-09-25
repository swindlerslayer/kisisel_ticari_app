import 'dart:convert';

import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Models/Gelirler/gelir.dart';
import 'package:kisisel_ticari_app/Models/Gelirler/gelir_liste.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';
import 'package:kisisel_ticari_app/URL/token.dart';
import 'package:http/http.dart' as http;

class GelirController extends GetxController {
  final _gelirList = <GelirListe>[].obs;
  List<GelirListe>? get gelirList => _gelirList;
  set gelirList(List<GelirListe>? value) => _gelirList;

  Future<List<GelirListe>?> getGelir(String kullaniciAdi, String parola) async {
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
        gelirList = gelirListeFromJson(response.body);
        return gelirList;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> gelirEkleDuzenle(KullaniciGiris kullanici, Gelir x) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullanici.kullaniciAdi,
        parola: kullanici.kullaniciAdi,
        loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/gelirekleduzenle');

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
