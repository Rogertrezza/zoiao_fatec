import 'package:flutter/material.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

// Controller
import 'loginController.dart';

// Model
import '../model/cliente.dart';

// View erro
import '../view/util.dart';

class clienteController{

  void adicionar(context, Cliente c){
    FirebaseFirestore.instance.collection('cliente')
      .add(c.toJson())
      .then((value) => sucesso(context,'Cliente Adicionado com sucesso!'))
      .catchError((e) => erro(context,'Não foi possível adicionar o cliente.'))
      .whenComplete(() => Navigator.pop(context));
  }

  //
  // Recuperar todas as tarefas do usuário que está logado
  //
  listar(){
    return FirebaseFirestore.instance.collection('cliente')
      .where('uid', isEqualTo: LoginController().idUsuario());
  }

  //
  // ATUALIZAR
  //
  void atualizar(context,id,Cliente c){    
    FirebaseFirestore.instance.collection('cliente')
    .doc(id)
    .update(c.toJson())
    .then((value) => sucesso(context,'Cliente atualizado com sucesso!'))
    .catchError((e) => erro(context,'Não foi possível atualizar o cliente.'))
    .whenComplete(() => Navigator.pop(context));
  }

  //
  // EXCLUIR
  // 
  void excluir(context,id){    
    FirebaseFirestore.instance.collection('cliente')
    .doc(id)
    .delete()
    .then((value) => sucesso(context,'Cliente excluída com sucesso!'))
    .catchError((e) => erro(context,'Não foi possível excluir o cliente.'));
  }

}