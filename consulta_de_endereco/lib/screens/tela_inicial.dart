import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  String resultado = 'Seu CEP aparecerá aqui';

  //controller para pegar o texto do textfield
  TextEditingController txtcep = TextEditingController();

  void mostrarCep() async {
    //recebe o cep do TextField
    String respCep = txtcep.text;

    //pegar url
    String url = 'https://viacep.com.br/ws/$respCep/json/';

    //variável para armazenar a resposta
    http.Response response;

    //efetuar a requisição para a url utilizanado o método get
    response = await http.get(Uri.parse(url));

    //colocando o response na variavel tipo map 'dados'
    Map<String, dynamic> dados = json.decode(response.body);

    String logradouro = dados['logradouro'];
    String complemento = dados['complemento'];
    String bairro = dados['bairro'];
    String localidade = dados['localidade'];
    String uf = dados['uf'];
    String estado = dados['estado'];
    String regiao = dados['regiao'];
    String cep = dados['cep'];

    String endereco =
        'Logradouro: $logradouro\nComplemento: $complemento\nBairro: $bairro\nLocalidade: $localidade\nUF: $uf\nEstado: $estado\nRegião: $regiao\nCEP: $cep';

    setState(() {
      resultado = endereco;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/localizacao_fundo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: TextField(
                controller: txtcep,
                selectionWidthStyle: BoxWidthStyle.tight,
                keyboardType: TextInputType.number,
                maxLength: 8,
                decoration: const InputDecoration(
                  labelText: 'Insira o CEP aqui',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            ElevatedButton(
              onPressed: mostrarCep,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: const Text(
                'Procurar',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              padding: const EdgeInsets.all(15),
              child: Text(
                resultado,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
