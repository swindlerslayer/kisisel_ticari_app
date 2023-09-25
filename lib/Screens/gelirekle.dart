//write a stateless widget  for the gelir ekle screen
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Components/bottombar.dart';
import 'package:kisisel_ticari_app/Controllers/gelir_controller.dart';
import 'package:kisisel_ticari_app/Models/Gelirler/gelir.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';
import 'package:kisisel_ticari_app/Screens/hesaplar.dart';

class GelirEkle extends StatelessWidget {
  const GelirEkle({Key? key, required this.kullanici}) : super(key: key);
  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    final secilihesap = 0.obs;

    //create 3 textcontroller
    TextEditingController gelirAdi = TextEditingController();
    TextEditingController gelirTutari = TextEditingController();
    TextEditingController gelirAciklamasi = TextEditingController();
    var gelirHesabi = TextEditingController().obs;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   var gelirler = await GelirController()
    //       .getGelir(kullanici.kullaniciAdi!, kullanici.parola!);
    // });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 213, 181, 255),
        shadowColor: const Color.fromARGB(0, 213, 181, 255),
        title: const Text("Gelir Ekle"),
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
                "Gelir Ekle",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: gelirAdi,
                  decoration: const InputDecoration(
                    labelText: "Gelir Adı",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: gelirTutari,
                  //only input numbers
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Gelir Tutarı",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: gelirAciklamasi,
                  decoration: const InputDecoration(
                    labelText: "Gelir Açıklaması",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              //Textfield for  the gelir hesabi has plus icon button on the right side when clicked its goes to Hesaplar screen
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => TextFormField(
                    controller: gelirHesabi.value,
                    decoration: const InputDecoration(
                      labelText: "Gelir Hesabı",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () {
                      Get.to(HesapSayfasi(
                        kullanici: kullanici,
                      ))?.then((value) {
                        if (value != null) {
                          gelirHesabi.value.text = value.hesapAdi.toString();

                          //set value.id to something to use later
                          secilihesap.value = value.id;
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
                  var cont = GelirController();
                  var gelir = Gelir(
                      id: 0,
                      gelirTutari: int.parse(gelirTutari.text),
                      gelirAciklama: gelirAciklamasi.text,
                      gelirTarihi: null,
                      gelirHesabi: secilihesap.value,
                      kullaniciId: kullanici.id!);
                  cont.gelirEkleDuzenle(kullanici, gelir).then((value) {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Gelir Eklendi")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Gelir Eklenemedi")));
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
