import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zoiao/model/funcionario.dart';

import '../view/util.dart';
import 'loginController.dart';

class FuncionarioController{

  void adicionar(context, Funcionario f){
    FirebaseFirestore.instance.collection('funcionarios')
      .add(f.toJson())
      .then((value) => sucesso(context,'Oculos Adicionado com sucesso!'))
      .catchError((e) => erro(context,'Não foi possível adicionar o oculos.'))
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
    .then((value) => sucesso(context,'Oculos atualizado com sucesso!'))
    .catchError((e) => erro(context,'Não foi possível atualizar o oculos.'))
    .whenComplete(() => Navigator.pop(context));
  }

  //
  // EXCLUIR
  // 
  void excluir(context,id){    
    FirebaseFirestore.instance.collection('funcionarios')
    .doc(id)
    .delete()
    .then((value) => sucesso(context,'Oculos excluída com sucesso!'))
    .catchError((e) => erro(context,'Não foi possível excluir o oculos.'));
  }

}