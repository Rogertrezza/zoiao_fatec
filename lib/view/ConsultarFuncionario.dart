import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/funcionarioController.dart';

class ConsultarFuncionario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consultar Funcionário')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FuncionarioController().listar(),
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
              var funcionario = funcionarios[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(funcionario['nome']),
                subtitle: Text(funcionario['cargo']),
              );
            },
          );
        },
      ),
    );
  }
}
