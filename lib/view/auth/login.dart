import 'package:flutter/material.dart';
import 'package:flutter_app/components/components.dart';
import 'package:flutter_app/controller/auth_states.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: authState.authEmailCtrl),
            const SizedBox(height: 10),
            TextField(
              controller: authState.authPasswordCtrl,
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => authState.signIn(context),
                child: const Text("Entrar")),
            const SizedBox(height: 30),
            TextLink(
                text: "Esqueceu a senha?",
                onPressed: () =>
                    Navigator.of(context).pushNamed("/forgot-password")),
          ],
        ),
      )),
    ));
  }
}
