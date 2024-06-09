import 'package:flutter/material.dart';
import 'package:zoiao/controller/loginController.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  // Chave identificador do Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool passe_email = false;
  bool passe_senha = true;

  //Chave identificado do Form
  var formKey = GlobalKey<FormState>();
  final TextEditingController emailLogin = TextEditingController();
  final TextEditingController senhaLogin = TextEditingController();

  bool validarCampos(String email, String senha) {
    // Verifica se o campo de e-mail está vazio
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail não pode estar vazio')),
      );
      return false;
    }

    // Verifica se o campo de e-mail possui um formato válido
    final emailValido =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (!emailValido) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail inválido')),
      );
      return false;
    }

    // Verifica se o campo de senha está vazio
    if (senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha não pode estar vazia')),
      );
      return false;
    }

    // Verifica se a senha tem pelo menos 6 caracteres
    if (senha.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('A senha deve ter pelo menos 6 caracteres')),
      );
      return false;
    }

    // Se passou por todas as verificações, retorna verdadeiro
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Atribuição da scaffoldKey ao Scaffold
      appBar: AppBar(
        title: const Text("Tela de login"),
        automaticallyImplyLeading: false,
      ),
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    "lib/img/logo.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: emailLogin,
                    obscureText: passe_email ? true : false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: senhaLogin,
                    obscureText: passe_senha ? true : false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text("senha"),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          if (passe_senha == true) {
                            passe_senha = false;
                          } else {
                            passe_senha = true;
                          }
                          setState(() {});
                        },
                        child: passe_senha
                            ? const Icon(Icons.remove_red_eye_outlined)
                            : const Icon(Icons.remove_red_eye_rounded),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: const Color(0xFF7165d6),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          // Chama o controller para adicionar usuario
                          var email = emailLogin.text;
                          var senha = senhaLogin.text;
                          if (validarCampos(email, senha)) {
                            LoginController().login(
                              context,
                              email,
                              senha,
                            );
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          child: Center(
                            child: Text(
                              "Entrar",
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Esqueceu a senha?"),
                            content: SizedBox(
                              height: 150,
                              child: Column(
                                children: [
                                  const Text(
                                    "Identifique-se para receber um e-mail com as instruções e o link para criar uma nova senha.",
                                  ),
                                  const SizedBox(height: 25),
                                  TextField(
                                    controller: emailLogin,
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actionsPadding: const EdgeInsets.all(20),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  LoginController().esqueceuSenha(
                                    context,
                                    emailLogin.text,
                                  );

                                  Navigator.pop(context);
                                },
                                child: const Text('enviar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Esqueceu a senha?'),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Não possui uma conta?",
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
                          'registrar',
                        );
                      },
                      child: const Text(
                        "Criar conta",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7165D6)),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Saiba mais sobre o projeto",
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
                          'sobre',
                        );
                      },
                      child: const Text(
                        "Clique aqui",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7165D6)),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
