import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Controllers/login_controller.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';
import 'package:kisisel_ticari_app/Screens/home_screen.dart';
import 'package:kisisel_ticari_app/Screens/loading.dart';
import 'package:kisisel_ticari_app/Screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({Key? key, this.kullaniciadi, this.parola, this.ischecked})
      : super(key: key);
  final String? kullaniciadi;
  final String? parola;
  final bool? ischecked;

  @override
  Widget build(BuildContext context) {
    var cont = Get.put(LoginController());
    TextEditingController kadicont =
        TextEditingController(text: kullaniciadi?.toString());
    TextEditingController kpcont =
        TextEditingController(text: parola?.toString());
    return Scaffold(
      body: Center(
        child: Container(
          //add a gradiant background to login screen
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 167, 136, 255),
                Color.fromARGB(255, 255, 255, 255),
              ],
            ),
          ),
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Giriş Ekranı',
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.purple[900],
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Kullanıcı Adı',
                style: TextStyle(fontSize: 20, color: Colors.purple[500]),
              ),
              TextField(
                controller: kadicont,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kullanıcı Adı',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Şifre',
                style: TextStyle(fontSize: 20, color: Colors.purple[500]),
              ),
              TextField(
                obscureText: true,
                controller: kpcont,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Şifre',
                ),
              ),
              //add remember me checkbox and text beside it
              Row(
                children: [
                  Obx(() => Checkbox(
                        value: cont.checkedstatus ?? true,
                        onChanged: (bool? value) async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          cont.checkedstatus = value!;
                          if (cont.checkedstatus == true) {
                            await prefs.setBool(
                                'ischecked', cont.checkedstatus!);
                          } else {
                            await prefs.setBool(
                                'ischecked', cont.checkedstatus!);
                          }
                        },
                      )),
                  const Text('Beni Hatırla'),
                ],
              ),

              ElevatedButton(
                onPressed: () async {
                  LoginController loginController = LoginController();

                  KullaniciGiris? loggedInUser = await loginController
                      .loginUser(kadicont.text, kpcont.text);

                  if (loggedInUser?.kullaniciAdi != null) {
                    Get.to(LoadingScreen(
                      nextpage: HomePage(kullanici: loggedInUser!),
                    ));
                  } else {
                    Get.defaultDialog(
                        title: "Giriş Başarısız",
                        middleText: "Girdiğiniz bilgiler Yanlış",
                        backgroundColor:
                            const Color.fromARGB(255, 110, 57, 57));
                  }
                },
                child: const Text('Giriş Yap'),
              ),
              CupertinoButton(
                onPressed: () {
                  Get.to(() => const Register());
                },
                child: const Text('Kayıt Ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
