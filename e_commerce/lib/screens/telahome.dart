import 'dart:convert';
import 'package:e_commerce/components/produtos.dart';
import 'package:e_commerce/screens/telagestao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelahomeState();
}

class _TelahomeState extends State<TelaHome> {
  //Vamos codar a nossa lógica
  List listaProdutos = [];

  @override
  void initState() {
    super.initState();
    fazerGet();
  }

  void fazerGet() async {
    //Variavel final = variável que começa sem valor e depois recebe.
    //é muito utilizada para respostas de API/Servidor e banco de dados.
    final respostaServidor = await http.get(
      Uri.parse("https://mercadinho-da-ju.onrender.com/produtos"),
    ); //URI trasnforma string em URL
    if (respostaServidor.statusCode == 200) {
      final dados = jsonDecode(
        respostaServidor.body,
      ); //jsonDecode decodifica os pacotes mandados pelo Servidor no body (Header e body)
      setState(() {
        listaProdutos = dados;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.list, color: Colors.purple[700]),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaGestao()),
                );
              },
              icon: Icon(Icons.settings),
              color: const Color(0xFF7B1FA2),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: listaProdutos.isEmpty
          ? Center(child: Text("Carregando produtos..."))
          : GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: [
                for (final produto in listaProdutos)
                  Produtos(
                    nome: produto["nome"],
                    urlImagem: produto["imagem"],
                    preco: produto["preco"],
                  ),
              ],
            ),
    );
  }
}
