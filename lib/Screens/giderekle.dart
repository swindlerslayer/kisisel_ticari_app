//write a stateless widget  for the gelir ekle screen
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Components/bottombar.dart';
import 'package:kisisel_ticari_app/Controllers/gider_controller.dart';
import 'package:kisisel_ticari_app/Models/Harcamalar/gider.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';
import 'package:kisisel_ticari_app/Screens/hesaplar.dart';

class GiderEkle extends StatelessWidget {
  const GiderEkle({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    final secilihesap = 0.obs;

    //create 3 textcontroller
    TextEditingController giderAdi = TextEditingController();
    TextEditingController giderTutari = TextEditingController();
    TextEditingController giderAciklamasi = TextEditingController();
    var giderHesabi = TextEditingController().obs;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   var giderler = await giderController()
    //       .getgider(kullanici.kullaniciAdi!, kullanici.parola!);
    // });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 213, 181, 255),
        shadowColor: const Color.fromARGB(0, 213, 181, 255),
        title: const Text("Gider Ekle"),
      ),
      body: SingleChildScrollView(
        child: Container(
          //expond the container to the whole screen
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

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
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Gider Ekle",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: giderAdi,
                  decoration: const InputDecoration(
                    labelText: "Gider Adı",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: giderTutari,
                  //only input numbers
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Gider Tutarı",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: giderAciklamasi,
                  decoration: const InputDecoration(
                    labelText: "Gider Açıklaması",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => TextFormField(
                    controller: giderHesabi.value,
                    decoration: const InputDecoration(
                      labelText: "Gider Hesabı",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () {
                      Get.to(HesapSayfasi(
                        kullanici: kullanici,
                      ))?.then((value) {
                        if (value != null) {
                          giderHesabi.value.text = value.hesapAdi.toString();
                          print(value.id);

                          //set value.id to something to use later
                          secilihesap.value = value.id;
                          print(secilihesap.value);
                        }
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  var cont = GiderController();
                  var gider = Gider(
                      id: 0,
                      harcamaTutari: int.parse(giderTutari.text),
                      harcamaAciklama: giderAciklamasi.text,
                      harcamaTarihi: null,
                      harcamaHesabi: secilihesap.value,
                      kullaniciId: kullanici.id!);
                  print(gider.harcamaHesabi);
                  cont.giderEkleDuzenle(kullanici, gider).then((value) {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Gider Eklendi")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Gider Eklenemedi")));
                    }
                  });
                },
                child: const Text("Kaydet"),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        kullanici: kullanici,
      ),
    );
  }
}
