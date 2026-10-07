import 'package:e_commerce/navigation/navbar.dart';
import 'package:e_commerce/screens/telahome.dart';
import 'package:e_commerce/screens/telalogin.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Aqui codamos a lógica
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaLogin()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://www.gruporoxo.com.br/estatico/img/logo.png",
              width: 100,
            ),
            CircularProgressIndicator(color: Colors.deepPurple[200]),
          ],
        ),
      ),
    );
  }
}
