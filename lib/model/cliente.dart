class Cliente{

  //Especificação das "chaves" do documento
  final String uid;
  final String nome;
  final String telefone;
  final String rg;
  final String endereco;
  final String receita;
  final String data_receita;

  //Construtor
  Cliente(this.uid, 
          this.nome, 
          this.telefone,
          this.rg,
          this.endereco,
          this.receita,
          this.data_receita);

  //
  // toJson = converte um OBJETO da linguagem DART
  //          em um JSON
  //
  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      'uid' : uid,
      'nome': nome,
      'telefone': telefone,
      'rg': rg,
      'endereco': endereco,
      'receita': receita,
      'data_receita': data_receita,
    };
  }

  //
  // fromJson = converter um JSON em um OBJETO
  //            da linguagem DART
  //
  factory Cliente.fromJson(Map<String,dynamic> dados){
    return Cliente(
      dados['uid'],
      dados['nome'],
      dados['telefone'],
      dados['rg'],
      dados['endereco'],
      dados['receita'],
      dados['data_receita'],
    );
  }

}