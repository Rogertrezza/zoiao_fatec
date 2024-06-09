import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/funcionarioController.dart';

class ExcluirFuncionario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Excluir Funcionário')),
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
              var funcionario = funcionarios[index];
              var funcionarioData = funcionario.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(funcionarioData['nome']),
                subtitle: Text(funcionarioData['cargo']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    FuncionarioController().excluir(context, funcionario.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
