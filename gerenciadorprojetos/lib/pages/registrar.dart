import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/models/user.dart';

class Registrar extends StatefulWidget {
  const Registrar({super.key});
  @override
  State<Registrar> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Registrar> {
  final TextEditingController nomes = TextEditingController();
  final TextEditingController emails = TextEditingController();
  final TextEditingController usernames = TextEditingController();
  final TextEditingController senhas = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFF),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logobranca.png',
                    width: 150,
                    height: 150,
                    isAntiAlias: true,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextField(
                    controller: nomes,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Nome',
                      hintText: "Nome completo",
                      labelStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xFF30BCED),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: emails,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Email',
                      hintText: "Exemplo@exemplo.com",
                      labelStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xFF30BCED),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: usernames,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Username',
                      hintText: "Apelido",
                      labelStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xFF30BCED),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: senhas,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Senha',
                      labelStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xFF30BCED),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF30BCED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: registrar,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 104.0,
                        vertical: 15,
                      ),
                      child: Text(
                        'Registrar-se',
                        style: TextStyle(
                          color: Color(0xFFFFFAFF),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text("Ja possui conta ?"),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                      ),
                      primary: Color(0xFF30BCED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registrar() {
    String pass = senhas.text;
    String email = emails.text;
    String username = usernames.text;
    String nome = nomes.text;
    if (pass.isNotEmpty &&
        email.isNotEmpty &&
        username.isNotEmpty &&
        nome.isNotEmpty) {
      User novo = User(
        Nome: nome,
        Email: email,
        Password: pass,
        Usuario: username,
        grupos: [],
      );
      Navigator.of(context).pushNamed('/login');
    } else {}
  }
}