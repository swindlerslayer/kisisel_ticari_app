import 'dart:convert';

import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';
import 'package:kisisel_ticari_app/URL/token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final _kullanicigiris = KullaniciGiris().obs;
  KullaniciGiris get kullanicigiris => _kullanicigiris.value;
  set kullanicigiris(KullaniciGiris value) => _kullanicigiris.value = value;

  final _checkedstatus = true.obs;
  bool? get checkedstatus => _checkedstatus.value;
  set checkedstatus(bool? value) => _checkedstatus.value = value!;

  final _loginstatus = false.obs;
  bool? get loginstatus => _loginstatus.value;
  set loginstatus(bool? value) => _loginstatus.value = value!;
  

    Future<String> getUserCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? kullaniciadi = prefs.getString('kullaniciAdi');
    final String? kullaniciparola = prefs.getString('parola');
    return "$kullaniciadi + $kullaniciparola";
  }

  Future<bool> isCheckedBefore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? ischecked = prefs.getBool('ischecked');

    if (ischecked == true) {
      return true;
    } else {
      return false;
    }
  }



  Future<KullaniciGiris?> loginUser(String kullaniciAdi, String parola) async {
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    var baseUrl = ApiEndPoints.baseUrl;
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/api/kullanici/kullaniciBul?kullaniciAdi=$kullaniciAdi&parola=$parola'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        KullaniciGiris? kullanici = KullaniciGiris?.fromJson(responseData);
        kullanici.parola = parola;
        KullaniciController controller = KullaniciController();
        controller.value = kullanici.toString();
        Get.put(LoginController()).kullanicigiris = kullanici;

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('kullaniciAdi', kullanici.kullaniciAdi!);
        await prefs.setString('parola', kullanici.parola!);

        return kullanici;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
