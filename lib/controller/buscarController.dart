import 'package:zoiao/model/busca.dart';

import 'package:flutter/material.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

// Controller
import 'loginController.dart';

class BuscaController {
  final BuscaModel buscaModel = BuscaModel();

  Stream<List<dynamic>> buscar(String searchText, String tipoBusca) {
    switch (tipoBusca) {
      case 'cliente':
        return buscaModel.buscarClientes(searchText);
      case 'venda':
        return buscaModel.buscarVendas(searchText);
      case 'oculos':
        return buscaModel.buscarOculos(searchText);
      default:
        throw Exception('Tipo de busca inválido');
    }
  }

    //
  // Listar Cliente
  //
  listarCliente(context, nome) {
    return FirebaseFirestore.instance
        .collection('cliente')
        .where('nome', isEqualTo: nome)
        .where('uid', isEqualTo: LoginController().idUsuario());
  }

  //
  // Listar Oculos
  //
  listarOculos(context, codigo_oculos) {
    return FirebaseFirestore.instance
        .collection('cliente')
        .where('codigo_oculos', isEqualTo: codigo_oculos)
        .where('uid', isEqualTo: LoginController().idUsuario());
  }

  //
  // Listar Vendas
  //
  listarVendas(context, nota_fiscal) {
    return FirebaseFirestore.instance
        .collection('cliente')
        .where('nota_fiscal', isEqualTo: nota_fiscal)
        .where('uid', isEqualTo: LoginController().idUsuario());
  }

}

