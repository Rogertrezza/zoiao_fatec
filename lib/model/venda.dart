class Venda{

  //Especificação das "chaves" do documento
  final String uid;
  final String nota_fiscal;
  final String codigo_oculos;
  final String codigo_cliente;
  final String preco_venda;
  final String data_venda;

  //Construtor
  Venda(this.uid, 
        this.nota_fiscal,
          this.codigo_oculos,
          this.codigo_cliente, 
          this.preco_venda,
          this.data_venda);

  //
  // toJson = converte um OBJETO da linguagem DART
  //          em um JSON
  //
  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      'uid' : uid,
      'nota_fiscal': nota_fiscal,
      'codigo_oculos': codigo_oculos,
      'codigo_cliente': codigo_cliente,
      'preco_venda': preco_venda,
      'data_venda': data_venda,
    };
  }

  //
  // fromJson = converter um JSON em um OBJETO
  //            da linguagem DART
  //
  factory Venda.fromJson(Map<String,dynamic> dados){
    return Venda(
      dados['uid'],
      dados['nota_fiscal'],
      dados['codigo_oculos'],
      dados['codigo_cliente'],
      dados['preco_venda'],
      dados['data_venda'],
    );
  }

}