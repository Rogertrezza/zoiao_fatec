class Funcionario{

  //Especificação das "chaves" do documento
  final String uid;
  final String nome;
  final String telefone;
  final String rg;
  final String endereco;
  final String data_inicio;

  //Construtor
  Funcionario(this.uid, 
          this.nome, 
          this.telefone,
          this.rg,
          this.endereco,
          this.data_inicio);

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
      'data_inicio': data_inicio,
    };
  }

  //
  // fromJson = converter um JSON em um OBJETO
  //            da linguagem DART
  //
  factory Funcionario.fromJson(Map<String,dynamic> dados){
    return Funcionario(
      dados['uid'],
      dados['nome'],
      dados['telefone'],
      dados['rg'],
      dados['endereco'],
      dados['data_inicio'],
    );
  }

}