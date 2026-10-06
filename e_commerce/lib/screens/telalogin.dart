import 'package:e_commerce/navigation/navbar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController emailDigitado = TextEditingController();
  TextEditingController senhaDigitada = TextEditingController();

  void fazerLogin() async {
    final respostaServidor = await http.get(
      Uri.parse("https://mercadinho-da-ju.onrender.com/usuarios"),
    );
    if (respostaServidor.statusCode == 200) {
      final usuarios = jsonDecode(respostaServidor.body);
      for (dynamic usuario in usuarios) {
        if (emailDigitado.text == usuario["email"] &&
            senhaDigitada.text == usuario["senha"]) {
          usuarioId = usuario["id"];
          usuarioEmail = usuario["email"];
          usuarioSenha = usuario["senha"];

          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBar()),
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 50),
            TextField(
              controller: emailDigitado,
              decoration: InputDecoration(hintText: "Digite seu email..."),
            ),
            TextField(
              controller: senhaDigitada,
              decoration: InputDecoration(hintText: "Digite sua senha..."),
            ),
            TextButton(onPressed: () => fazerLogin(), child: Text("Logar")),
          ],
        ),
      ),
    );
  }
}

dynamic usuarioId;
dynamic usuarioEmail;
dynamic usuarioSenha;
