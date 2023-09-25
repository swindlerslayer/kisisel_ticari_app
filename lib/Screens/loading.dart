import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, this.kullanici, required this.nextpage})
      : super(key: key);

  static const routeName = '/loading';
  final KullaniciGiris? kullanici;
  final StatelessWidget? nextpage;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 1), () {
        Get.to(() => nextpage!);
      });
    });
    //|-_-|\\
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
