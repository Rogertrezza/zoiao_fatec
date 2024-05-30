// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

// Controller
import 'package:zoiao/controller/oculoscontroller.dart';
import '../controller/loginController.dart';

// Model
import 'package:zoiao/model/oculos.dart';

class cadastrarOculos extends StatefulWidget {
  const cadastrarOculos({super.key});

  @override
  State<cadastrarOculos> createState() => _cadastrarOculosState();
}

class _cadastrarOculosState extends State<cadastrarOculos> {
  var txtoculos_codigo = TextEditingController();
  var txtoculos_marca = TextEditingController();
  var txtoculos_modelo= TextEditingController();
  var txtoculos_preco = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oculos'),
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
          stream: oculosController().listar().snapshots(),

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
                        title: Text(item['codigo']),
                        subtitle: Text(item['marca']),
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
                                  txtoculos_codigo.text = item['codigo'];
                                  txtoculos_marca.text = item['marca']; // Corrigido
                                  txtoculos_modelo.text = item['modelo']; // Corrigido
                                  txtoculos_preco.text = item['preco']; // Corrigido
                                  salvarOculos(context, docId: id);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_outlined),
                                onPressed: () {
                                  oculosController().excluir(context, id);
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
                    child: Text('Nenhum oculos encontrado.'),
                  );
                }
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          salvarOculos(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //
  // ADICIONAR Cliente
  //
  void salvarOculos(context, {docId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text((docId == null) ? "Adicionar Oculos" : "Editar Oculos"),
          content: SizedBox(
            height: 250,
            width: 300,
            child: SingleChildScrollView(
              // Adicionando SingleChildScrollView aqui
              child: Column(
                children: [
                  SizedBox(height: 15),
                  TextField(
                    controller: txtoculos_codigo,
                    decoration: InputDecoration(
                      labelText: 'Codigo do oculos',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: txtoculos_marca,
                    decoration: InputDecoration(
                      labelText: 'Marca',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: txtoculos_modelo,
                    decoration: InputDecoration(
                      labelText: 'Modelo',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: txtoculos_preco,
                    decoration: InputDecoration(
                      labelText: 'Preco',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(),
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
                txtoculos_codigo.clear();
                txtoculos_marca.clear();
                txtoculos_modelo.clear();
                txtoculos_preco.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                //instanciar um OBJETO Tarefa
                var o = Oculos(
                  LoginController().idUsuario(),
                  txtoculos_codigo.text,
                  txtoculos_marca.text,
                  txtoculos_modelo.text,
                  txtoculos_preco.text,
                );

                if (docId == null) {
                  //adicionar tarefa
                  oculosController().adicionar(context, o);
                } else {
                  //atualizar tarefa
                  oculosController().atualizar(context, docId, o);
                }

                //limpar os campos de texto
                txtoculos_codigo.clear();
                txtoculos_marca.clear();
                txtoculos_modelo.clear();
                txtoculos_preco.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
