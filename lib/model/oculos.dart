class Oculos{

  //Especificação das "chaves" do documento
  final String uid;
  final String codigo;
  final String marca;
  final String modelo;
  final String preco;

  //Construtor
  Oculos(this.uid, 
          this.codigo, 
          this.marca,
          this.modelo,
          this.preco);

  //
  // toJson = converte um OBJETO da linguagem DART
  //          em um JSON
  //
  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      'uid' : uid,
      'codigo': codigo,
      'marca': marca,
      'modelo': modelo,
      'preco': preco,
    };
  }

  //
  // fromJson = converter um JSON em um OBJETO
  //            da linguagem DART
  //
  factory Oculos.fromJson(Map<String,dynamic> dados){
    return Oculos(
      dados['uid'],
      dados['codigo'],
      dados['marca'],
      dados['modelo'],
      dados['preco'],
    );
  }

}