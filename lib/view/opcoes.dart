import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoiao/controller/loginController.dart';
import '../controller/usuarioController.dart';

class Opcoes extends StatefulWidget {
  const Opcoes({Key? key}) : super(key: key);

  @override
  OpcoesState createState() => OpcoesState();
}

class OpcoesState extends State<Opcoes> {
  String? _nomeUsuario;

  @override
  void initState() {
    super.initState();
    _carregarNomeUsuario();
  }

  Future<void> _carregarNomeUsuario() async {
    String nome = await UsuarioController().nomeUsuario();
    setState(() {
      _nomeUsuario = nome;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('usuarios')
          .where('uid', isEqualTo: LoginController().idUsuario())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        var nome = '';
        if (snapshot.hasData) {
          var docs = snapshot.data!.docs;
          if (docs.isNotEmpty) {
            var data = docs.first.data() as Map<String, dynamic>?; // Convertendo para Map<String, dynamic>
            if (data != null && data.containsKey('nome')) {
              nome = data['nome'] ?? '';
            }
          }
        }
        return _buildOpcoesScreen(nome);
      },
    );
  }

  Widget _buildOpcoesScreen(String nomeUsuario) {
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
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100, shape: BoxShape.circle),
                child: Icon(Icons.notification_add,
                    color: Colors.deepPurple, size: 25),
              ),
              title: Text(
                "Notificação",
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

  void _showUserDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
          stream: UsuarioController().listar(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return AlertDialog(
                title: Text('Detalhes do Usuário'),
                content: Text('Nenhuma informação encontrada.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Fechar'),
                  ),
                ],
              );
            }

            var dados = snapshot.data!.docs.first;
            var userData = dados.data() as Map<String, dynamic>;

            TextEditingController nomeController =
                TextEditingController(text: userData['nome']);
            TextEditingController emailController =
                TextEditingController(text: userData['nome_empresa']);
            TextEditingController cnpjController =
                TextEditingController(text: userData['cnpj']);
            TextEditingController telefoneController =
                TextEditingController(text: userData['telefone:']);

            return AlertDialog(
              title: Text('Detalhes do Usuário'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: cnpjController,
                      decoration: InputDecoration(labelText: 'CNPJ'),
                    ),
                    TextField(
                      controller: telefoneController,
                      decoration: InputDecoration(labelText: 'Telefone'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Fechar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> updatedData = {
                      'nome': nomeController.text,
                      'nome_empresa': emailController.text,
                      'cnpj': cnpjController.text,
                      'telefone': telefoneController.text,
                    };
                    UsuarioController().atualizar(context, dados.id, updatedData);
                    Navigator.pop(context);
                  },
                  child: Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
