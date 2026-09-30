import 'package:e_commerce/screens/telahome.dart';
import 'package:e_commerce/screens/telaperfil.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  //Aqui here eu i codo codo minha my logica logic
  int indexAtual = 0;

  void mudarIndex(int novoIndex){
    setState(() {
      indexAtual = novoIndex;
    });
  }

  List paginas = [
    TelaHome(),
    TelaPerfil()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginas.elementAt(indexAtual),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "Perfil", icon: Icon(Icons.person))
      ],
      currentIndex: indexAtual,
      onTap: mudarIndex,
      backgroundColor: const Color.fromARGB(255, 248, 205, 255),
      selectedItemColor: const Color.fromARGB(255, 45, 15, 49),
      ),
    );
  }
}