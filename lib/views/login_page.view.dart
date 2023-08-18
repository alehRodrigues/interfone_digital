import 'package:flutter/material.dart';
import 'package:interfone_digital/services/auth_service.dart';
import 'package:interfone_digital/utils/mixins/validation_mixin.dart';
import 'package:interfone_digital/utils/providers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  final confirmaSenha = TextEditingController();

  final authService = getIt<AuthService>();

  bool isLogin = true;
  bool passwordVisible = false;
  bool isLoading = false;

  late String titulo;
  late String btnAction;
  late String textBtnToggle;

  @override
  void initState() {
    super.initState();
    setFormRole(true);
  }

  setFormRole(bool isLogin) {
    setState(() {
      this.isLogin = isLogin;
      if (isLogin) {
        titulo = 'Login';
        btnAction = 'Entrar';
        textBtnToggle = 'Ainda não tem conta? Cadastre-se agora.';
      } else {
        titulo = 'Cadastro';
        btnAction = 'Cadastrar';
        textBtnToggle = 'Já tem conta? Entre agora.';
      }
    });
  }

  login(context) async {
    var messageError = await authService.login(email.text, senha.text);

    if (messageError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(messageError),
        backgroundColor: Colors.red,
      ));
    }
  }

  registrar(context) async {
    var messageError = await authService.registrar(email.text, senha.text);

    if (messageError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(messageError),
        backgroundColor: Colors.red,
      ));
    }
  }

  googleProvider(context) async {
    var messageError = await authService.loginGoogle();
    if (messageError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(messageError),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    senha.dispose();
    confirmaSenha.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text('Interfone Digital',
                          style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(height: 20),
                      Text(titulo,
                          style: Theme.of(context).textTheme.headlineMedium),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            prefixIconColor: Colors.greenAccent,
                            labelText: 'E-mail',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, informe o e-mail';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: TextFormField(
                          controller: senha,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              prefixIconColor: Colors.greenAccent,
                              labelText: 'Senha',
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                icon: passwordVisible
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                color: Colors.greenAccent,
                              )),
                          validator: (value) => isValidPassword(value, null),
                        ),
                      ),
                      if (!isLogin)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: TextFormField(
                            controller: confirmaSenha,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                prefixIconColor: Colors.greenAccent,
                                labelText: 'Repita a Senha',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  icon: passwordVisible
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  color: Colors.greenAccent,
                                )),
                            validator: (value) =>
                                isValidPassword(value, senha.text),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(200, 50))),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (isLogin) {
                                login(context);
                              } else {
                                registrar(context);
                              }
                            }
                          },
                          child: Text(btnAction),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setFormRole(!isLogin);
                        },
                        child: Text(textBtnToggle),
                      ),
                      const SizedBox(height: 25),
                      Row(children: [
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(left: 15, right: 10),
                          child: const Divider(
                            color: Colors.white70,
                          ),
                        )),
                        const Text('OU'),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 15),
                          child: const Divider(
                            color: Colors.white70,
                          ),
                        )),
                      ]),
                      const SizedBox(height: 25),
                      ElevatedButton.icon(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(300, 50))),
                          onPressed: () {
                            googleProvider(context);
                            setState(() {
                              isLoading = !isLoading;
                            });
                          },
                          icon: const Icon(Icons.g_mobiledata),
                          label: const Text('Entrar com Google')),
                    ],
                  )),
            ),
          ))
        : const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
