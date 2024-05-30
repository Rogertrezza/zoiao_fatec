// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoiao/controller/vendaController.dart';

// Controller
import '../controller/loginController.dart';

// Model
import '../model/venda.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({super.key});

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  var txtnota_fiscal = TextEditingController();
  var txtcodigo_oculos = TextEditingController();
  var txtcodigo_cliente = TextEditingController();
  var txtpreco_venda = TextEditingController();
  var txtdata_venda = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendas'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              LoginController().logout(context);
              Navigator.pop(context);
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),

      // BODY
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        //
        // Exibir as TAREFAS
        //
        child: StreamBuilder<QuerySnapshot>(
          //fluxo de dados
          stream: vendaController().listar().snapshots(),

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
                        title: Text(item['nota_fiscal']),
                        subtitle: Text(item['preco_venda']),
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
                                  txtnota_fiscal.text = item['nota_fiscal'];
                                  txtcodigo_oculos.text = item['codigo_oculos'];
                                  txtcodigo_cliente.text =
                                      item['codigo_cliente'];
                                  txtpreco_venda.text = item['preco_venda'];
                                  txtdata_venda.text = item['data_venda'];
                                  salvarVenda(context, docId: id);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_outlined),
                                onPressed: () {
                                  vendaController().excluir(context, id);
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
                    child: Text('Nenhuma venda encontrada.'),
                  );
                }
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          salvarVenda(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //
  // ADICIONAR TAREFA
  //
  void salvarVenda(context, {docId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text((docId == null) ? "Adicionar Venda" : "Editar Venda"),
          content: SizedBox(
              height: 250,
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    TextField(
                      controller: txtnota_fiscal,
                      decoration: InputDecoration(
                        labelText: 'Nota fiscal',
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: txtcodigo_oculos,
                      decoration: InputDecoration(
                        labelText: 'Codigo do oculos',
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: txtcodigo_cliente,
                      decoration: InputDecoration(
                        labelText: 'Rg do cliente',
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: txtpreco_venda,
                      decoration: InputDecoration(
                        labelText: 'Preco venda',
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: txtdata_venda,
                      decoration: InputDecoration(
                        labelText: 'Data venda',
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              )),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          actions: [
            TextButton(
              child: Text("fechar"),
              onPressed: () {
                txtnota_fiscal.clear();
                txtcodigo_oculos.clear();
                txtcodigo_cliente.clear();
                txtpreco_venda.clear();
                txtdata_venda.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              onPressed: () {
                //instanciar um OBJETO Tarefa
                var v = Venda(
                  LoginController().idUsuario(),
                  txtnota_fiscal.text,
                  txtcodigo_oculos.text,
                  txtcodigo_cliente.text,
                  txtpreco_venda.text,
                  txtdata_venda.text,
                );

                if (docId == null) {
                  //adicionar tarefa
                  vendaController().adicionar(context, v);
                } else {
                  //atualizar tarefa
                  vendaController().atualizar(context, docId, v);
                }

                //limpar os campos de texto
                txtnota_fiscal.clear();
                txtcodigo_oculos.clear();
                txtcodigo_cliente.clear();
                txtpreco_venda.clear();
                txtdata_venda.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
