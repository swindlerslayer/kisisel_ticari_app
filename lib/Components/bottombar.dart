import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisisel_ticari_app/Models/Kullanici/kullanici.dart';
import 'package:kisisel_ticari_app/Screens/cash_screen.dart';
import 'package:kisisel_ticari_app/Screens/home_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.kullanici});

  final KullaniciGiris kullanici;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 176, 116, 255),
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.handshake),
          ),
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.edit_document),
          ),
          IconButton(
            iconSize: 45,
            onPressed: () {
              Get.to(() => HomePage(kullanici: kullanici));
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.account_balance),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => CashScreen(kullanici: kullanici));
            },
            icon: const Icon(Icons.account_balance_wallet),
          ),
        ],
      ),
    );
  }
}
         
// import 'package:flutter/material.dart';

// class BottomBar extends StatelessWidget {
//   const BottomBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const BottomAppBar(
//       color: Color.fromARGB(255, 167, 136, 255),
//       shape: CircularNotchedRectangle(),
//       child: SizedBox(
//         height: 60,
//         child: Row(
          
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               icon: Icon(Icons.home),
//               onPressed: null,
//             ),
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: null,
//             ),

            
//             IconButton(
//               icon: Icon(Icons.notifications),
//               onPressed: null,
//             ),
//             IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: null,
//             ),
            
//           ],
//         ),
//       ),
      
//     );
    
    
//   }
// }



