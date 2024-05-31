import 'package:flutter/material.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

// Controller
import 'loginController.dart';

// Model
import '../model/funcionario.dart';

// View erro
import '../view/util.dart';

class clienteController{

  void adicionar(context, Funcionario f){
    FirebaseFirestore.instance.collection('funcionarios')
      .add(f.toJson())
      .then((value) => sucesso(context,'Funcionario Adicionado com sucesso!'))
      .catchError((e) => erro(context,'Não foi possível adicionar o Funcionario'))
      .whenComplete(() => Navigator.pop(context));
  }

  //
  // Recuperar todas as tarefas do usuário que está logado
  //
  listar(){
    return FirebaseFirestore.instance.collection('funcionarios')
      .where('uid', isEqualTo: LoginController().idUsuario());
  }

  //
  // ATUALIZAR
  //
  void atualizar(context,id,Funcionario f){    
    FirebaseFirestore.instance.collection('funcionarios')
    .doc(id)
    .update(f.toJson())
    .then((value) => sucesso(context,'Funcionario atualizado com sucesso!'))
    .catchError((e) => erro(context,'Não foi possível atualizar o funcionario.'))
    .whenComplete(() => Navigator.pop(context));
  }

  //
  // EXCLUIR
  // 
  void excluir(context,id){    
    FirebaseFirestore.instance.collection('funcionarios')
    .doc(id)
    .delete()
    .then((value) => sucesso(context,'Funcionario excluída com sucesso!'))
    .catchError((e) => erro(context,'Não foi possível excluir o funcionario.'));
  }

}