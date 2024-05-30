import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:zoiao/firebase_options.dart';


// Paginas do Projeto
import 'package:zoiao/view/sobre.dart';
import 'package:zoiao/view/login/registrar.dart';
import 'package:zoiao/view/login/login.dart';
import 'package:zoiao/view/inicial.dart';
import 'package:zoiao/view/PrincipalView.dart';
import 'package:zoiao/widgets/navBar.dart';

Future<void> main() async {
  //
  // FireBase
  //
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegação',
      //Rotas de navegação
      initialRoute: 'inicial',
      routes: {
        'inicial': (context) => inicial(),
        'login': (context) => login(),
        'registrar' : (context) => registrar(),
        'PrincipalView':(context) => PrincipalView(),
       // 'cadastro':(context) => cadastro(userRepository: userRepository),
        'navBar': (context) => navBar(),
        'sobre':(context) => sobre(),
       // 'buscar':(context) => buscaItem(listaDeComprasRepository: listaDeComprasRepository),
      },
    );
  }
}
