import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/oculos.dart';
import '../view/util.dart';
import 'loginController.dart';

class oculosController{

  void adicionar(context, Oculos o){
    FirebaseFirestore.instance.collection('oculos')
      .add(o.toJson())
      .then((value) => sucesso(context,'Oculos Adicionado com sucesso!'))
      .catchError((e) => erro(context,'Não foi possível adicionar o oculos.'))
      .whenComplete(() => Navigator.pop(context));
  }

  //
  // Recuperar todas as tarefas do usuário que está logado
  //
  listar(){
    return FirebaseFirestore.instance.collection('oculos')
      .where('uid', isEqualTo: LoginController().idUsuario());
  }

  //
  // ATUALIZAR
  //
  void atualizar(context,id,Oculos o){    
    FirebaseFirestore.instance.collection('oculos')
    .doc(id)
    .update(o.toJson())
    .then((value) => sucesso(context,'Oculos atualizado com sucesso!'))
    .catchError((e) => erro(context,'Não foi possível atualizar o oculos.'))
    .whenComplete(() => Navigator.pop(context));
  }

  //
  // EXCLUIR
  // 
  void excluir(context,id){    
    FirebaseFirestore.instance.collection('oculos')
    .doc(id)
    .delete()
    .then((value) => sucesso(context,'Oculos excluída com sucesso!'))
    .catchError((e) => erro(context,'Não foi possível excluir o oculos.'));
  }

}