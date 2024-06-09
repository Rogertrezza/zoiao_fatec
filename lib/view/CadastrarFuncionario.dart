import 'package:flutter/material.dart';
import 'package:zoiao/model/funcionario.dart';
import '../controller/funcionarioController.dart';

class CadastrarFuncionario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController cargoController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Funcionário')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: cargoController,
              decoration: InputDecoration(labelText: 'Cargo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> funcionarioData = {
                  'nome': nomeController.text,
                  'cargo': cargoController.text,
                };
                FuncionarioController().adicionar(context, funcionarioData as Funcionario);
                Navigator.pop(context);
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
