import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gerenciadorprojetos/pages/adicionarProj.dart';
import 'package:gerenciadorprojetos/pages/atAtv.dart';
import 'package:gerenciadorprojetos/pages/criagrupo.dart';
import 'package:gerenciadorprojetos/pages/grupos.dart';
import 'package:gerenciadorprojetos/pages/projetoT.dart';
import 'package:gerenciadorprojetos/pages/projetos.dart';
import 'package:gerenciadorprojetos/pages/registrar.dart';
import 'package:gerenciadorprojetos/pages/tela_login.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RoteadorTela(),
      routes: {
        '/registrar': (context) => Registrar(),
        '/login': (context) => TelaLogin(),
        '/grupos': (context) => Grupos(),
        '/criagrupo': (context) => CriaGrupo(),
        '/Projetos': (context) => Projetos(),
        '/CriaProj': (context) => CriaProj(),
        '/ProjetoT': (context) => ProjetoT(),
        '/TelaAtv': (context) => AtvTela(),
      },
    );
  }
}

class RoteadorTela extends StatefulWidget {
  const RoteadorTela({super.key});

  @override
  State<RoteadorTela> createState() => _RoteadorTelaState();
}

class _RoteadorTelaState extends State<RoteadorTela> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Grupos();
        } else {
          return TelaLogin();
        }
      },
    );
  }
}
