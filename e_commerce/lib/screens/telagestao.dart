import 'dart:convert';

import 'package:e_commerce/components/minhaappbar.dart';
import 'package:e_commerce/navigation/navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaGestao extends StatefulWidget {
  const TelaGestao({super.key});

  @override
  State<TelaGestao> createState() => _TelaGestaoState();
}

class _TelaGestaoState extends State<TelaGestao> {
  TextEditingController nomeDigitado = TextEditingController();
  TextEditingController urlDigitada = TextEditingController();
  TextEditingController precoDigitado = TextEditingController();

  @override
  void initState() {
    super.initState();
    fazerGet();
  }

  void fazerPost() async {
    final respostaServidor = await http.post(
      Uri.parse("https://mercadinho-da-ju.onrender.com/produtos"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nome": nomeDigitado.text,
        "preco": precoDigitado.text,
        "imagem": urlDigitada.text,
      }),
    );
    if (mounted) {
      if (respostaServidor.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Dado Criado com Sucesso!")));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavBar()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro ao Criar Dado!")));
      }
    }
  }

  List listaProdutos = [];
  void fazerGet() async {
    final respostaServidor = await http.get(
      Uri.parse("https://mercadinho-da-ju.onrender.com/produtos"),
    );
    if (respostaServidor.statusCode == 200) {
      final dados = jsonDecode(respostaServidor.body);
      setState(() {
        listaProdutos = dados;
      });
    }
  }

  void fazerDelete(dynamic id) async {
    final respostaServidor = await http.delete(
      Uri.parse("https://mercadinho-da-ju.onrender.com/produtos/$id"),
    );

    if (mounted) {
      if (respostaServidor.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Item deletado com sucesso")));
        fazerGet();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro ao deletar Item")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinhaAppBar(),
      body: ListView(
        children: [
          TextField(
            controller: nomeDigitado,
            decoration: InputDecoration(hintText: "Digite o nome do produto: "),
          ),
          TextField(
            controller: precoDigitado,
            decoration: InputDecoration(
              hintText: "Digite o preço do produto: ",
            ),
          ),
          TextField(
            controller: urlDigitada,
            decoration: InputDecoration(
              hintText: "Digite a URL da imagem do produto: ",
            ),
          ),
          TextButton(onPressed: () => fazerPost(), child: Text("Salvar")),
          for (dynamic produto in listaProdutos)
            ListTile(
              title: Text(produto["nome"]),
              trailing: IconButton(
                onPressed: () => fazerDelete(produto["id"]),
                icon: Icon(Icons.delete),
              ),
            ),
        ],
      ),
    );
  }
}
