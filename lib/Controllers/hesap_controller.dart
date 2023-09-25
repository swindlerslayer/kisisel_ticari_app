import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Models/Hesaplar/hesaplar.dart';
import 'package:kisisel_ticari_app/URL/token.dart';
import 'package:http/http.dart' as http;

class HesapController extends GetxController {
  final _hesapList = <Hesaplar>[].obs;
  List<Hesaplar>? get hesapList => _hesapList;
  set hesapList(List<Hesaplar>? value) => _hesapList.value = value!;

  


  Future<List<Hesaplar>?> hesaplistele(
      String kullaniciAdi, String parola, int hesap) async {
    var apilink = ApiEndPoints.baseUrl;
    var token = await TokenService.getToken(
        kullaniciAdi: kullaniciAdi, parola: parola, loginMi: false);
    try {
      final response = await http.get(
        Uri.parse('$apilink/api/hesapgetirliste?id=$hesap'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${token.accessToken}"
        },
      );

      if (response.statusCode == 200) {
        List<Hesaplar> hesap = hesaplarFromJson(response.body);
        //set hesap to hesaplist
        hesapList = hesap;
     

        return hesapList;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
