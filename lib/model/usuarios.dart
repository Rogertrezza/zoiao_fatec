class Usuario {
  final String uid;
  final String cnpj;
  final String nome;
  final String nome_empresa;
  final String telefone;

  Usuario(this.uid, this.cnpj, this.nome, this.nome_empresa, this.telefone);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'cnpj': cnpj,
      'nome': nome,
      'nome_empresa': nome_empresa,
      'telefone': telefone,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> dados) {
    return Usuario(
      dados['uid'],
      dados['cnpj'],
      dados['nome'],
      dados['nome_empresa'],
      dados['telefone'],
    );
  }
}
