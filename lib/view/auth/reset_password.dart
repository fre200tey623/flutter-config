import 'package:flutter/material.dart';
import 'package:flutter_app/components/components.dart';
import 'package:flutter_app/controller/auth_states.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
            TextField(
              controller: authState.authPasswordCtrl,
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: authState.authPasswordConfirmCtrl,
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => authState.resetPassword(context),
                child: const Text("Salvar")),
            const SizedBox(height: 30),
            TextLink(
                text: "Lembrou a senha? Faça login",
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false)),
          ],
        ),
      )),
    ));
  }
}
