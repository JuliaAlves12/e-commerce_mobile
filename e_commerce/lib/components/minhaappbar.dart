import 'package:e_commerce/navigation/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MinhaAppBar extends StatelessWidget  implements PreferredSizeWidget {
  const MinhaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF7B1FA2),
      title: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBar()),
            ),
            icon: Icon(Icons.arrow_back),
          ),
          Text("Tela Gestão"),
        ],
      ),
    );
  }
   @override
  Size get PreferredSize => const Size.fromHeight(kToolbarHeight);
}