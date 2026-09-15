import 'package:e_commerce/screens/telahome.dart';
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
      ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Telahome()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://i.pinimg.com/1200x/eb/db/a0/ebdba048cc96435b12ea49d6369fbdfc.jpg", width: 100),
            CircularProgressIndicator(color: Colors.deepPurple)
          ],
        ),
      ),
    );
  }
}