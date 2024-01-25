import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_app/services/api.dart';

import 'package:flutter_app/controller/auth_states.dart';
import 'package:flutter_app/config/firebase_options.dart';
import 'package:flutter_app/view/auth/forgot_password.dart';
import 'package:flutter_app/view/auth/login.dart';
import 'package:flutter_app/view/auth/recover_code.dart';
import 'package:flutter_app/view/auth/reset_password.dart';
import 'package:flutter_app/view/home/initial.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
      future: initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          FlutterNativeSplash.remove();
          requestPermissions();

          var signedIn = snapshot.data != null && snapshot.data == true;
          var route = signedIn ? "/" : "/";

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => AuthState()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: route,
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

        return const SizedBox();
      },
    );
  }
}

Future<bool> initializeApp() async {
  bool signedIn = false;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingService().setupFirebase();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  var email = sharedPreferences.getString("email");
  var token = sharedPreferences.getString("token");
  var firebaseToken = sharedPreferences.getString("firebaseToken");

  if (email != null && token != null && firebaseToken != null) {
    for (int i = 0; i < 3; i++) {
      signedIn = await autoLogin(email, token, firebaseToken);

      if (signedIn) break;
    }
  }

  return signedIn;
}

Future<bool> autoLogin(String email, String token, String firebaseToken) async {
  MyHttp http = MyHttp();

  var data = {
    "email": email,
    "firebaseToken": firebaseToken,
  };

  var response = await http.post(getApiUrl("/user/refresh-token"), body: data);

  return response.statusCode == 200;
}

Future<void> requestPermissions() async {
  await Permission.notification.request();
}
