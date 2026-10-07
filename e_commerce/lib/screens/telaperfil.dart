import 'dart:convert';

import 'package:e_commerce/screens/telalogin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  TextEditingController emailTrocar = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailTrocar.text = usuarioEmail;
  }

  void fazerPatch(dynamic Id) async {
    final respostaServidor = await http.patch(
      Uri.parse("https://mercadinho-da-ju.onrender.com/usuarios/$Id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": emailTrocar.text}),
    );
    if (respostaServidor.statusCode == 200) {
      setState(() {
        usuarioEmail = emailTrocar.text;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Dado alterado com suceso!")));
      });
    }
  }

  void sair() {
    usuarioEmail = null;
    usuarioSenha = null;
    usuarioId = null;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => TelaLogin()),
      ((route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 50),
          TextField(controller: emailTrocar),
          TextButton(
            onPressed: () => fazerPatch(usuarioId),
            child: Text("Alterar"),
          ),
          TextButton(onPressed: () => sair(), child: Text("Sair")),
        ],
      ),
    );
  }
}
