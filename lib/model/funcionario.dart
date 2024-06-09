class Funcionario{

  //Especificação das "chaves" do documento
  final String uid;
  final String nome_completo;
  final String cpf;
  final String data_inicio;
  final String endereco;
  final String cargo;

  //Construtor
  Funcionario(this.uid,
              this.nome_completo,
              this.cpf,
              this.endereco,
              this.data_inicio,
              this.cargo,);

  //
  // toJson = converte um OBJETO da linguagem DART
  //          em um JSON
  //
  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      'uid' : uid,
      'nome_completo': nome_completo,
      'cpf': cpf,
      'endereco': endereco,
      'data_inicio': data_inicio,
      'cargo': cargo,
    };
  }

  //
  // fromJson = converter um JSON em um OBJETO
  //            da linguagem DART
  //
  factory Funcionario.fromJson(Map<String,dynamic> dados){
    return Funcionario(
      dados['uid'],
      dados['nome_completo'],
      dados['cpf'],
      dados['endereco'],
      dados['data_inicio'],
      dados['cargo'],
    );
  }

}