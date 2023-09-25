import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Components/bottombar.dart';
import 'package:kisisel_ticari_app/Controllers/hesap_controller.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';

class HesapSayfasi extends StatelessWidget {
  const HesapSayfasi({super.key, required this.kullanici});
  final KullaniciGiris kullanici;
  @override
  Widget build(BuildContext context) {
    var cont = Get.put(HesapController());
    //call the listeleme api call
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var dd = await HesapController().hesaplistele(
          kullanici.kullaniciAdi!, kullanici.parola!, kullanici.id!);

      cont.hesapList = dd!;
    });
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text("Hesaplar"),
          backgroundColor: const Color.fromARGB(255, 213, 181, 255),
        ),
        body: Container(
            //expond the container to the whole screen
            height: MediaQuery.of(context).size.height,

            //write a decoration for the container that matches the home screen
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
            child: Column(children: [
              Obx(() => ListView(shrinkWrap: true, children: [
                    ...cont.hesapList!.asMap().entries.map(
                          (e) => ListTile(
                            leading: const Icon(Icons.account_balance_wallet),
                            title: Text(e.value.hesapAdi),
                            trailing: Text(e.value.hesapBakiyesi.toString()),
                            onTap: () {
                                  
                              //set secilenhesap to selected hesap id 
                              Get.back(result: e.value);
                            },
                          ),
                        )
                  ]))
            ])),

        //call the bottom bar widget
        bottomNavigationBar: BottomBar(kullanici: kullanici));
  }
}
