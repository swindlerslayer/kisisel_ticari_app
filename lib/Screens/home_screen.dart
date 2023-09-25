import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisisel_ticari_app/Components/bottombar.dart';
import 'package:kisisel_ticari_app/Controllers/kullanici_controller.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';
import 'package:kisisel_ticari_app/Screens/gelirekle.dart';
import 'package:kisisel_ticari_app/Screens/giderekle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.kullanici});

  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    //calculate screen height
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //give appbar a background color that matches the bottombar
        shadowColor: const Color.fromARGB(0, 213, 181, 255),
        leading: kullanici.resim1 != null
            ? CircleAvatar(
                radius: 15,
                backgroundImage: MemoryImage(kullanici.resim1), //here
              )
            : GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text("Kameradan Çek"),
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? photo = await picker.pickImage(
                                      imageQuality: 50,
                                      maxHeight: 1000,
                                      maxWidth: 1000,
                                      source: ImageSource.camera);
                                  if (photo == null) return;
                                  File? file = File(photo.path);
                                  kullanici.resim1 = await file.readAsBytes();

                                  KullaniciControllerr().kullaniciGuncelle(
                                      kullanici.kullaniciAdi!,
                                      kullanici.parola!,
                                      kullanici);

                                  Get.back();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text("Galeriden Seç"),
                                onTap: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? photo = await picker.pickImage(
                                      imageQuality: 50,
                                      maxHeight: 1000,
                                      maxWidth: 1000,
                                      source: ImageSource.gallery);
                                  if (photo == null) return;
                                  File? file = File(photo.path);
                                  kullanici.resim1 = await file.readAsBytes();

                                  KullaniciControllerr().kullaniciGuncelle(
                                      kullanici.kullaniciAdi!,
                                      kullanici.parola!,
                                      kullanici);

                                  Get.back();
                                },
                              )
                            ],
                          ));
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/1053/1053244.png'),
                ),
              ),
        title: Text(kullanici.kullaniciAdi.toString()),
        //give appbar a bottom border
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.black,
            height: 1.0,
            thickness: 0.5,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            //toplam ekran boyutunun yüzde 30'u kadar yer kaplar
            height: screenHeight * 0.3,
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.auto_graph_outlined),
              ),
            ),
          ),
        ],
        //hesaplar  hareketler   kullanıcılar
      ),
      bottomNavigationBar: BottomBar(
        kullanici: kullanici,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //pop up a dialog to select add expense or income
          showModalBottomSheet(
              context: context,
              builder: (context) => SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.add),
                          title: const Text("Gelir Ekle"),
                          onTap: () {
                            //route to GelirEkle screen with get
                            Get.to(GelirEkle(
                              kullanici: kullanici,
                            ));
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.remove),
                          title: const Text("Gider Ekle"),
                          onTap: () {
                            Get.to( GiderEkle(kullanici: kullanici));
                          },
                        )
                      ],
                    ),
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
