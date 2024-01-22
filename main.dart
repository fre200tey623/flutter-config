import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_states.dart';
import 'package:flutter_application_1/view/auth/forgot_password.dart';
import 'package:flutter_application_1/view/auth/login.dart';
import 'package:flutter_application_1/view/auth/recover_code.dart';
import 'package:flutter_application_1/view/auth/reset_password.dart';
import 'package:flutter_application_1/view/home/initial.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: verifyToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => AuthState()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: snapshot.data != null && snapshot.data == true
                  ? "/"
                  : "/login",
              routes: {
                "/": (context) => const InitialPage(),
                "/login": (context) => const LoginPage(),
                "/forgot-password": (context) => const ForgotPasswordPage(),
                "/recover-code": (context) => const RecoverCodePage(),
                "/reset-password": (context) => const ResetPasswordPage(),
              },
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

Future<bool> verifyToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.getString("token");

  return token != null;
}
