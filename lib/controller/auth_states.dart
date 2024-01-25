// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/user/usuario.dart';
import 'package:flutter_app/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState extends ChangeNotifier {
  User? user;
  TextEditingController authEmailCtrl = TextEditingController();
  TextEditingController authPasswordCtrl = TextEditingController();
  TextEditingController authPasswordConfirmCtrl = TextEditingController();
  TextEditingController authCodeCtrl = TextEditingController();
  MyHttp http = MyHttp();

  Future<void> signIn(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      var token = sharedPreferences.getString("firebaseToken");

      var data = {
        "email": authEmailCtrl.text,
        "password": authPasswordCtrl.text,
        "firebaseToken": token,
      };

      var response = await http.post(getApiUrl("/user/login"), body: data);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var token = data["token"];

        user = User.fromJson(data["user"]);

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        sharedPreferences.setString("token", token);
        sharedPreferences.setString("email", user!.email);

        http.setToken(token);

        Navigator.pushReplacementNamed(context, "/");

        authEmailCtrl.clear();
        authPasswordCtrl.clear();
      } else {
        var error = jsonDecode(response.body)["errors"]["message"];

        print('Erro: $error');
      }
    } catch (e) {
      print('Erro: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> signOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove("token");

    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);

    notifyListeners();
  }

  Future<void> forgotPassword(BuildContext context) async {
    try {
      var data = {
        "email": authEmailCtrl.text,
      };

      var response = await http.post(getApiUrl("/forgot-password"), body: data);

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, "/recover-code");
      } else {
        var error = jsonDecode(response.body)["errors"]["message"];

        print('Erro: $error');
      }
    } catch (e) {
      print('Erro: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> validateCode(BuildContext context) async {
    try {
      var data = {
        "email": authEmailCtrl.text,
        "code": authCodeCtrl.text,
      };

      var response = await http.post(getApiUrl("/validate-code"), body: data);

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, "/reset-password");
      } else {
        var error = jsonDecode(response.body)["errors"]["message"];

        print('Erro: $error');
      }
    } catch (e) {
      print('Erro: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      var data = {
        "email": authEmailCtrl.text,
        "code": authCodeCtrl.text,
        "password": authPasswordCtrl.text,
      };

      var response = await http.post(getApiUrl("/update-password"), body: data);

      if (response.statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      } else {
        var error = jsonDecode(response.body)["errors"]["message"];

        print('Erro: $error');
      }
    } catch (e) {
      print('Erro: $e');
    } finally {
      notifyListeners();
    }
  }
}
