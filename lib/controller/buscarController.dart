import 'package:zoiao/model/busca.dart';


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
  listarOculos(context, codigoOculos) {
    return FirebaseFirestore.instance
        .collection('cliente')
        .where('codigo_oculos', isEqualTo: codigoOculos)
        .where('uid', isEqualTo: LoginController().idUsuario());
  }

  //
  // Listar Vendas
  //
  listarVendas(context, notaFiscal) {
    return FirebaseFirestore.instance
        .collection('cliente')
        .where('nota_fiscal', isEqualTo: notaFiscal)
        .where('uid', isEqualTo: LoginController().idUsuario());
  }

}

