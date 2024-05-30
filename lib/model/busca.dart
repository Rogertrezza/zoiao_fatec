// busca_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/loginController.dart';

class BuscaModel {
  final CollectionReference clientesCollection = FirebaseFirestore.instance.collection('cliente');
  final CollectionReference vendasCollection = FirebaseFirestore.instance.collection('vendas');
  final CollectionReference oculosCollection = FirebaseFirestore.instance.collection('oculos');

  Stream<List<dynamic>> buscarClientes(String searchText) {
    Query query = clientesCollection;

    if (searchText.isNotEmpty) {
      query = query.where('nome', isEqualTo: searchText);
      query = query.where('uid', isEqualTo: LoginController().idUsuario());
    }
    else{
      query = query.where('uid', isEqualTo: LoginController().idUsuario());
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Stream<List<dynamic>> buscarVendas(String searchText) {
    Query query = vendasCollection;

    if (searchText.isNotEmpty) {
      query = query.where('nota_fiscal', isEqualTo: searchText);
      query = query.where('uid', isEqualTo: LoginController().idUsuario());
    }
    else{
      query = query.where('uid', isEqualTo: LoginController().idUsuario());
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Stream<List<dynamic>> buscarOculos(String searchText) {
    Query query = oculosCollection;

    if (searchText.isNotEmpty) {
      query = query.where('codigo', isEqualTo: searchText);
      query = query.where('uid', isEqualTo: LoginController().idUsuario());
    }
    else{
      query = query.where('uid', isEqualTo: LoginController().idUsuario());
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}
