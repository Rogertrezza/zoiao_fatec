import 'package:flutter/material.dart';
import 'package:zoiao/controller/loginController.dart';

class registrar extends StatefulWidget {
  const registrar({super.key});

  @override
  State<registrar> createState() => _registrarState();
}

class _registrarState extends State<registrar> {
  // Chave identificador do Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Atributos
  bool senhapasse = true;

  //Chave identificado do Form
  var formKey = GlobalKey<FormState>();
  final TextEditingController nomeCadastro = TextEditingController();
  final TextEditingController nomeEmpresa = TextEditingController();
  final TextEditingController telefoneCadastro = TextEditingController();
  final TextEditingController CNPJ = TextEditingController();
  final TextEditingController emailCadastro = TextEditingController();
  final TextEditingController senhaCadastro = TextEditingController();

  bool _containsLetterAndNumber(String value) {
    // Verifica se a senha contém pelo menos uma letra e um número
    return RegExp(r'[a-zA-Z]').hasMatch(value) && RegExp(r'\d').hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Atribuição da scaffoldKey ao Scaffold
      appBar: AppBar(
        title: const Text("Registrar"),
      ),
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      "lib/img/logo.png",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: nomeCadastro,
                      decoration: const InputDecoration(
                        labelText: "Nome completo",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      //
                      // VALIDAÇÃO
                      //
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe um nome.';
                        }
                        // Retornar null significa sucesso na validação
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: nomeEmpresa,
                      decoration: const InputDecoration(
                        labelText: "Nome da sua empresa",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.business),
                      ),
                      //
                      // VALIDAÇÃO
                      //
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o nome da sua empresa.';
                        }
                        // Retornar null significa sucesso na validação
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: emailCadastro,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      //
                      // VALIDAÇÃO
                      //
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          // Verifica se o campo está vazio
                          return 'Informe um e-mail.';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          // Verifica se o e-mail está em um formato válido usando uma expressão regular
                          return 'Informe um e-mail válido.';
                        }
                        // Retornar null significa que a validação passou
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: telefoneCadastro,
                      decoration: const InputDecoration(
                        labelText: "Telefone",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      //
                      // VALIDAÇÃO
                      //
                      validator: (value) {
                        if (value == null) {
                          return 'Informe um telefone.';
                        } else if (value.isEmpty) {
                          return 'Informe um telefone.';
                        } else if (double.tryParse(value) == null) {
                          return 'Apenas numero.';
                        }
                        //Retornar null significa sucesso na validação
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: CNPJ,
                      decoration: const InputDecoration(
                        labelText: "CNPJ",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.business),
                      ),
                      //
                      // VALIDAÇÃO
                      //
                      validator: (value) {
                        if (value == null) {
                          return 'Informe um CNPJ.';
                        } else if (value.isEmpty) {
                          return 'Informe um CNPJ.';
                        } else if (double.tryParse(value) == null) {
                          return 'Apenas numero.';
                        }
                        //Retornar null significa sucesso na validação
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: senhaCadastro,
                      obscureText: senhapasse ? true : false,
                      decoration: InputDecoration(
                        labelText: "senha",
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (senhapasse == true) {
                              senhapasse = false;
                            } else {
                              senhapasse = true;
                            }
                            setState(() {});
                          },
                          child: senhapasse
                              ? const Icon(Icons.remove_red_eye_outlined)
                              : const Icon(Icons.remove_red_eye_rounded),
                        ),
                      ),
                      //
                      // VALIDAÇÃO
                      //
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe uma senha';
                        } else if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        } else if (!_containsLetterAndNumber(value)) {
                          return 'A senha deve conter letras e números';
                        }
                        // Retornar null significa sucesso na validação
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Material(
                        color: const Color(0xFF7165d6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              // Se o formulário for válido, crie o usuário

                              // Adicione o usuário ao repositório
                              LoginController().criarConta(
                                context,
                                nomeCadastro.text,
                                emailCadastro.text,
                                senhaCadastro.text,
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            child: Center(
                              child: Text(
                                "Criar Conta",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Já possui uma conta?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            'login',
                          );
                        },
                        child: const Text(
                          "Logar",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7165D6)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
