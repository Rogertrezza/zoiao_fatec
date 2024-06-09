import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zoiao/view/util.dart';
import 'loginController.dart';

class UsuarioController {
  //
  // Recuperar as Informações do usuário
  //
  Stream<QuerySnapshot> listar() {
    return FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: LoginController().idUsuario())
        .snapshots();
  }

  //
  // Atualiza as Informações do usuário
  //
  void atualizar(BuildContext context, String id, Map<String, dynamic> dadosAtualizados) {
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(id)
        .update(dadosAtualizados)
        .then((value) => sucesso(context, 'Venda atualizada com sucesso!'))
        .catchError((e) => erro(context, 'Não foi possível atualizar a Venda.'));
  }

String nomeUsuario() {
  String nome = '';

  FirebaseFirestore.instance
      .collection('usuarios')
      .where('uid', isEqualTo: LoginController().idUsuario())
      .get()
      .then((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      nome = querySnapshot.docs.first.data()['nome'];
    }
  });

  return nome;
}

}
