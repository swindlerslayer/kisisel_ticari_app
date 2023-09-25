import 'dart:convert';

import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';
import 'package:kisisel_ticari_app/URL/token.dart';
import 'package:http/http.dart' as http;

class KullaniciControllerr extends GetxController {
   Future<String> kullaniciGuncelle(
      String kullaniciAdi, String parola, KullaniciGiris k) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var client = http.Client();
    var url = Uri.parse('${ApiEndPoints.baseUrl}api/kullaniciresimguncelle');

    try {
      var headers = <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token.accessToken}"
      };
      var badi = json.encode(k);
      final response = await client.post(url, headers: headers, body: badi);
      if (response.statusCode == 200) {
        return "Eklendi";
      } else if (response.statusCode == 500) {
        return k.id.toString();
      } else {
        return "?";
      }
    } catch (e) {
      return "?";
    }
  }
}
