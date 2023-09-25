import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Components/bottombar.dart';
import 'package:kisisel_ticari_app/Controllers/hesap_controller.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';

class CashScreen extends StatelessWidget {
  const CashScreen({super.key, required this.kullanici});

  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    var cont = Get.put(HesapController());
    int toplamBakiye = 0;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var dd = await HesapController().hesaplistele(
          kullanici.kullaniciAdi!, kullanici.parola!, kullanici.id!);

      cont.hesapList = dd!;
    });
    for (var element in cont.hesapList!) {
      toplamBakiye += element.hesapBakiyesi;
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 213, 181, 255),
          title: Text(kullanici.kullaniciAdi.toString()),
          leading: kullanici.resim1 != null
              ? CircleAvatar(
                  radius: 15,
                  backgroundImage: MemoryImage(kullanici.resim1), //here
                )
              : const CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/1053/1053244.png'),
                )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 213, 181, 255),
              Color.fromARGB(255, 235, 226, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            //1/3 of the screen
            //list all hesaplar and their bakiye sum

            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 251, 196, 245),
              borderRadius: BorderRadius.circular(20),
            ),
            //1/3 of the screen
            //list all hesaplar and their bakiye sum

            child: Text(
              "Toplam Bakiye: $toplamBakiye",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(kullanici: kullanici),
    );
  }
}
