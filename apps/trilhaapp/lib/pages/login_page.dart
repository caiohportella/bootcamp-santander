import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      flex: 5,
                      child: Image.network(
                        "https://hermes.digitalinnovation.one/assets/diome/logo.png",
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Já tem cadastro?",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text("Faça seu login e make the change_",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    height: 30,
                    alignment: Alignment.center,
                    child: TextField(
                      onChanged: (value) => email = value,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 0),
                        hintText: "Informe seu e-mail",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Colors.purpleAccent),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purpleAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purpleAccent),
                        ),
                      ),
                    )),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    obscureText: isPasswordVisible,
                    onChanged: (value) => password = value,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 0),
                      hintText: "Informe sua senha",
                      hintStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.lock_outline_rounded,
                          color: Colors.purpleAccent),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.purpleAccent),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (email.trim() == "caio@gmail.com" &&
                            password.trim() == "exorcise") {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Login ou senha inválidos"),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purpleAccent),
                      ),
                      child: const Text("Entrar",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 130,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text("Esqueci minha senha",
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text("Criar conta",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
