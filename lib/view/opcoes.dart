import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoiao/controller/loginController.dart';
import '../controller/usuarioController.dart';
import '../controller/funcionarioController.dart';
import '../model/funcionario.dart';

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
            var data = docs.first.data() as Map<String, dynamic>;
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
          ],
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

 void _showFuncionariosOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Funcionários',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FuncionarioController().listar().snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('Nenhum funcionário encontrado.'));
                    }
                    var funcionarios = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: funcionarios.length,
                      itemBuilder: (context, index) {
                        var funcionario = funcionarios[index];
                        var funcionarioData = funcionario.data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(funcionarioData['nome_completo']),
                          subtitle: Text(funcionarioData['cargo']),
                          trailing: SizedBox(
                            width: 80,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit_outlined),
                                  onPressed: () {
                                    _cadastrarOuEditarFuncionario(
                                      context,
                                      funcionario.id,
                                      funcionarioData,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete_outlined),
                                  onPressed: () {
                                    FuncionarioController().excluir(context, funcionario.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  _cadastrarOuEditarFuncionario(context);
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        );
      },
    );
  }

  void _cadastrarOuEditarFuncionario(BuildContext context, [String? docId, Map<String, dynamic>? funcionarioData]) {
    TextEditingController nomeController = TextEditingController(text: funcionarioData?['nome_completo']);
    TextEditingController cargoController = TextEditingController(text: funcionarioData?['cargo']);
    TextEditingController cpfController = TextEditingController(text: funcionarioData?['cpf']);
    TextEditingController dataInicioController = TextEditingController(text: funcionarioData?['data_inicio']);
    TextEditingController enderecoController = TextEditingController(text: funcionarioData?['endereco']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(docId == null ? 'Cadastrar Funcionário' : 'Editar Funcionário'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome Completo'),
                ),
                TextField(
                  controller: cpfController,
                  decoration: InputDecoration(labelText: 'CPF'),
                ),
                TextField(
                  controller: enderecoController,
                  decoration: InputDecoration(labelText: 'Endereço'),
                ),
                TextField(
                  controller: dataInicioController,
                  decoration: InputDecoration(labelText: 'Data de Início'),
                ),
                TextField(
                  controller: cargoController,
                  decoration: InputDecoration(labelText: 'Cargo'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                var funcionario = Funcionario(
                  LoginController().idUsuario(),
                  nomeController.text,
                  cpfController.text,
                  enderecoController.text,
                  dataInicioController.text,
                  cargoController.text,
                );

                if (docId == null) {
                  FuncionarioController().adicionar(context, funcionario);
                } else {
                  FuncionarioController().atualizar(context, docId, funcionario);
                }
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}