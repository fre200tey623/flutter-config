import 'package:flutter/material.dart';
import 'package:flutter_app/components/components.dart';
import 'package:flutter_app/controller/auth_states.dart';
import 'package:provider/provider.dart';

class RecoverCodePage extends StatefulWidget {
  const RecoverCodePage({super.key});

  @override
  State<RecoverCodePage> createState() => _RecoverCodePageState();
}

class _RecoverCodePageState extends State<RecoverCodePage> {
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
            TextField(controller: authState.authCodeCtrl),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => authState.validateCode(context),
                child: const Text("Próximo")),
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
