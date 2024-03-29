// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/projetos.dart';
import 'package:http/http.dart' as http;

import '../_comum/meu_snackbar.dart';
import '../models/grupo.dart';
import '../rep-serv/apilink.dart';
import '../rep-serv/authserv.dart';
import '../widget/emailIten.dart';

class GrupoOP extends StatefulWidget {
  final Grupo parametros;

  const GrupoOP({super.key, required this.parametros});

  @override
  State<GrupoOP> createState() => _GrupoOPState();
}

class _GrupoOPState extends State<GrupoOP> {
  List<String> usuarios = [];
  final TextEditingController emailG = TextEditingController();
  final UtilsRep utilsreps = UtilsRep();
  List<utils> util = [];
  Api api = Api();
  @override
  void initState() {
    super.initState();
    utilsreps.getutils().then((value) {
      setState(() {
        util = value;
        getUsers();
      });
    });
  }

  bool verificarNome(List<String> grupos, String nome) {
    for (int i = 0; i < grupos.length; i++) {
      if (grupos[i] == nome) {
        return true;
      }
    }
    return false;
  }

//usa a funcao acima e se nao existir ele adiciona
  void adicionarSeNaoExistir(List<String> usuarios, String novoTeste) {
    if (!verificarNome(usuarios, novoTeste)) {
      usuarios.add(novoTeste);
    }
  }

  void getUsers() async {
    Grupo g1 = widget.parametros;
    final Map<String, dynamic> data = {
      'grupo': g1.nome,
    };
    String apiUrl =api.getUsers();

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': util[0].token,
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      if (jsonData.containsKey('usuarios')) {
        final List<dynamic> gruposData = jsonData['usuarios'];

        // Agora você tem uma lista de objetos "doc" como Map<String, dynamic>
        for (final docData in gruposData) {
          // Acessar os campos individuais do objeto "doc"
          // ignore: non_constant_identifier_names
          final String Teste = docData;
          adicionarSeNaoExistir(usuarios, Teste);
        }
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Grupo g1 = widget.parametros;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff30BCED),
        title: Text(g1.nome),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Grupo parametrost = g1;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Projetos(parametros: parametrost),
              ),
            );
          },
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: emailG,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Email do integrantes',
                        hintText: "Exemplo@exemplo.com",
                        labelStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color(0xFF30BCED),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        String email = emailG.text;

                        if (email.isNotEmpty) {
                          String nomeGr = g1.nome;
                          String emailw = email.toLowerCase();
                          final Map<String, dynamic> data = {
                            'nomeGrupo': nomeGr,
                            'usuarios': [emailw],
                          };

                          String apiUrl = api.adicionarUser();

                          final response = await http.post(
                            Uri.parse(apiUrl),
                            headers: {
                              'Content-Type': 'application/json',
                              'x-auth-token': util[0].token,
                            },
                            body: jsonEncode(data),
                          );
                          if (response.statusCode == 200) {
                            // ignore: use_build_context_synchronously
                            mostrarSnackbar(
                                context: context, texto: "Usuario adicionado");
                          } else {
                            // ignore: use_build_context_synchronously
                            mostrarSnackbar(
                                context: context,
                                texto: "${response.statusCode}");
                          }
                          setState(() {
                            usuarios.add(email);
                          });
                        } else {}
                      },
                      child: Icon(
                        Icons.person_add,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Lista de participante:"),
              SizedBox(
                  height: 500,
                  width: 300,
                  child: ListView(
                    children: [
                      for (String user in usuarios)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: EmailList(email: user, onDelete: onDelete),
                        ),
                    ],
                  )),
            ],
          ),
        ),
      ]),
    );
  }

  void onDelete(String email) async {
    Grupo g1 = widget.parametros;
    if (g1.dono == util[0].email) {
      final Map<String, dynamic> data = {
        'nomeGrupo': g1.nome,
        'usuarios': [email],
      };

      String apiUrl = api.removerUser() ;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': util[0].token,
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        mostrarSnackbar(context: context, texto: "Usuario deletado");
      } else {
        // ignore: use_build_context_synchronously
        mostrarSnackbar(context: context, texto: "${response.statusCode}");
      }

      setState(() {
        usuarios.remove(email);
      });
    } else {
      mostrarSnackbar(
          context: context, texto: "Você não é o dono do grupo", isErro: true);
    }
  }
}
