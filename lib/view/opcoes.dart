import 'package:flutter/material.dart';

class Opcoes extends StatefulWidget {
  const Opcoes({Key? key}) : super(key: key);

  @override
  OpcoesState createState() => OpcoesState();
}

class _opcoesState extends State<opcoes> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Configuração",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Icon(Icons.person, color: Colors.indigo, size: 25),
              ),
              title: Text(
                nomeUsuario ?? "Carregando...",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            ),
            Divider(height: 50),
            ListTile(
              onTap: () {
                _showUserDetails(context);
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.indigo.shade100, shape: BoxShape.circle),
                child: Icon(Icons.person, color: Colors.indigo, size: 25),
              ),
              title: Text(
                "Perfil",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                _showFuncionariosOptions(context);
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100, shape: BoxShape.circle),
                child: Icon(Icons.group, color: Colors.deepPurple, size: 25),
              ),
              title: Text(
                "Funcionarios",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'sobre');
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.orange.shade100, shape: BoxShape.circle),
                child: Icon(Icons.info, color: Colors.orange, size: 25),
              ),
              title: Text(
                "Sobre",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 100),
            Divider(height: 50),
            ListTile(
              onTap: () {
                LoginController().logout(context);
                Navigator.pushNamed(context, 'login');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Deslogado com sucesso'),
                    duration: Duration(seconds: 6),
                  ),
                );
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.redAccent.shade100, shape: BoxShape.circle),
                child: Icon(Icons.logout, color: Colors.redAccent, size: 25),
              ),
              title: Text(
                "Sair",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
          ]
        ),
      ),
    );
  }

 void _showUserDetails(context) {
  showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text('Detalhes do Usuário'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nome:'),
            SizedBox(height: 10),
            Text('Email:'),
            SizedBox(height: 10),
            Text('Senha:'),
            SizedBox(height: 10),
            Text('Telefone:'),
            SizedBox(height: 10),
            // Adicione outras informações do usuário aqui conforme necessário
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Fechar'),
          ),
        ],
      );
    }, context: context,
  );
}
}