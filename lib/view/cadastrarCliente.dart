// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

// Controller
import 'package:zoiao/controller/clienteController.dart';
import '../controller/loginController.dart';

// Model
import 'package:zoiao/model/cliente.dart';

class cadastrarCliente extends StatefulWidget {
  const cadastrarCliente({super.key});

  @override
  State<cadastrarCliente> createState() => _cadastrarClienteState();
}

class _cadastrarClienteState extends State<cadastrarCliente> {
  
  var txtcliente_nome = TextEditingController();
  var txtcliente_telefone = TextEditingController();
  var txtcliente_rg = TextEditingController();
  var txtcliente_endereco = TextEditingController();
  var txtcliente_receita = TextEditingController();
  var txtcliente_data_receita = TextEditingController();

// Função de validação para o campo Nome do Cliente
String? validarNome(String? value) {
  if (value == null || value.isEmpty) {
    return 'Informe o nome do cliente.';
  }
  return null;
}

// Função de validação para o campo Telefone
String? validarTelefone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Informe o telefone do cliente.';
  }
  return null;
}

// Função de validação para o campo RG
String? validarRg(String? value) {
  if (value == null || value.isEmpty) {
    return 'Informe o RG do cliente.';
  }
  return null;
}

// Função de validação para o campo Endereço
String? validarEndereco(String? value) {
  if (value == null || value.isEmpty) {
    return 'Informe o endereço do cliente.';
  }
  return null;
}

// Função de validação para o campo Receita do Cliente
String? validarReceita(String? value) {
  if (value == null || value.isEmpty) {
    return 'Informe a receita do cliente.';
  }
  return null;
}

// Função de validação para o campo Data da Receita
String? validarDataReceita(String? value) {
  if (value == null || value.isEmpty) {
    return 'Informe a data da receita do cliente.';
  }
  return null;
}

// Função para validar todos os campos
bool validarCampos() {
  return validarNome(txtcliente_nome as String?) == null &&
         validarTelefone(txtcliente_telefone as String?) == null &&
         validarRg(txtcliente_rg as String?) == null &&
         validarEndereco(txtcliente_endereco as String?) == null &&
         validarReceita(txtcliente_receita as String?) == null &&
         validarDataReceita(txtcliente_data_receita as String?) == null;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        automaticallyImplyLeading: false,
      ),

      // BODY
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        //
        // Exibir as TAREFAS
        //
        child: StreamBuilder<QuerySnapshot>(
          //fluxo de dados
          stream: clienteController().listar().snapshots(),

          //exibição dos dados
          builder: (context, snapshot) {
            //verificar o status da conexão
            switch (snapshot.connectionState) {
              //sem conexão com do Firebase
              case ConnectionState.none:
                return Center(
                  child: Text('Não foi possível conectar ao banco de dados'),
                );

              //aguardando a recuperação dos dados
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );

              //recuperar e exibir os dados
              default:
                final dados = snapshot.requireData;
                if (dados.size > 0) {
                  //
                  // LISTVIEW
                  //
                  return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      //ID do documento
                      String id = dados.docs[index].id;
                      dynamic item = dados.docs[index].data();

                      return ListTile(
                        title: Text(item['nome']),
                        subtitle: Text(item['receita']),
                        //
                        // EDITAR e EXCLUIR
                        //
                        trailing: SizedBox(
                          width: 80,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit_outlined),
                                onPressed: () {
                                  txtcliente_nome.text = item['nome'];
                                  txtcliente_telefone.text =
                                      item['telefone']; // Corrigido
                                  txtcliente_rg.text = item['rg']; // Corrigido
                                  txtcliente_endereco.text =
                                      item['endereco']; // Corrigido
                                  txtcliente_receita.text = item['receita'];
                                  txtcliente_data_receita.text =
                                      item['data_receita'];
                                  salvarCliente(context, docId: id);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_outlined),
                                onPressed: () {
                                  clienteController().excluir(context, id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Nenhum cliente encontrado.'),
                  );
                }
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          salvarCliente(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //
  // ADICIONAR Cliente
  //
  void salvarCliente(context, {docId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text((docId == null) ? "Adicionar Cliente" : "Editar Cliente"),
          content: SizedBox(
            height: 250,
            width: 300,
            child: SingleChildScrollView(
              // Adicionando SingleChildScrollView aqui
              child: Column(
                children: [
                  SizedBox(height: 15),
                  TextField(
                    controller: txtcliente_nome,
                    decoration: InputDecoration(
                      labelText: 'Nome do Cliente',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: txtcliente_telefone,
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: txtcliente_rg,
                    decoration: InputDecoration(
                      labelText: 'RG',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: txtcliente_endereco,
                    decoration: InputDecoration(
                      labelText: 'Endereco',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: txtcliente_receita,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Receita do cliente',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: txtcliente_data_receita,
                    decoration: InputDecoration(
                      labelText: 'Data da receita',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          actions: [
            TextButton(
              child: Text("fechar"),
              onPressed: () {
                txtcliente_nome.clear();
                txtcliente_telefone.clear();
                txtcliente_rg.clear();
                txtcliente_receita.clear();
                txtcliente_endereco.clear();
                txtcliente_data_receita.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                //instanciar um OBJETO Tarefa
                var c = Cliente(
                  LoginController().idUsuario(),
                  txtcliente_nome.text,
                  txtcliente_telefone.text,
                  txtcliente_rg.text,
                  txtcliente_endereco.text,
                  txtcliente_receita.text,
                  txtcliente_data_receita.text,
                );

                if (docId == null) {
                  //adicionar tarefa
                      clienteController().adicionar(context, c);
                } else {
                  clienteController().atualizar(context, docId, c);
                }

                //limpar os campos de texto
                txtcliente_nome.clear();
                txtcliente_telefone.clear();
                txtcliente_rg.clear();
                txtcliente_receita.clear();
                txtcliente_endereco.clear();
                txtcliente_data_receita.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
