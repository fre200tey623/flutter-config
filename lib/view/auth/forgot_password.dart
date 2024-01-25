import 'package:flutter/material.dart';
import 'package:flutter_app/components/components.dart';
import 'package:flutter_app/controller/auth_states.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => authState.forgotPassword(context),
                child: const Text("Enviar")),
            const SizedBox(height: 30),
            TextLink(
                text: "Lembrou a senha? Faça login",
                onPressed: () => Navigator.of(context).pop()),
          ],
        ),
      )),
    ));
  }
}
