import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/venda.dart';
import '../view/util.dart';
import 'loginController.dart';

class vendaController{

  void adicionar(context, Venda v){
    FirebaseFirestore.instance.collection('vendas')
      .add(v.toJson())
      .then((value) => sucesso(context,'Venda adicionada com sucesso!'))
      .catchError((e) => erro(context,'Não foi possível adicionar a venda.'))
      .whenComplete(() => Navigator.pop(context));
  }

  //
  // Recuperar todas as tarefas do usuário que está logado
  //
  listar(){
    return FirebaseFirestore.instance.collection('vendas')
      .where('uid', isEqualTo: LoginController().idUsuario());
  }

  //
  // ATUALIZAR
  //
  void atualizar(context,id,Venda v){    
    FirebaseFirestore.instance.collection('vendas')
    .doc(id)
    .update(v.toJson())
    .then((value) => sucesso(context,'Venda atualizada com sucesso!'))
    .catchError((e) => erro(context,'Não foi possível atualizar a Venda.'))
    .whenComplete(() => Navigator.pop(context));
  }

  //
  // EXCLUIR
  // 
  void excluir(context,id){    
    FirebaseFirestore.instance.collection('vendas')
    .doc(id)
    .delete()
    .then((value) => sucesso(context,'Venda excluída com sucesso!'))
    .catchError((e) => erro(context,'Não foi possível excluir a venda.'));
  }

}