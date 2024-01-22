// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/model/user/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Add this line

class AuthState extends ChangeNotifier {
  User? usuario;
  TextEditingController authEmailCtrl = TextEditingController();
  TextEditingController authPasswordCtrl = TextEditingController();
  TextEditingController authPasswordConfirmCtrl = TextEditingController();
  TextEditingController authCodeCtrl = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    var url = Uri.parse('');

    try {
      var data = {
        "email": authEmailCtrl.text,
        "password": authPasswordCtrl.text,
      };
      Navigator.pushNamed(context, "/");

      var response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var token = data["token"];

        usuario = User.fromJson(data["user"]);

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        sharedPreferences.setString("token", token);

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

    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove("token");

    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);

    notifyListeners();
  }

  Future<void> forgotPassword(BuildContext context) async {
    var url = Uri.parse('');

    try {
      var data = {
        "email": authEmailCtrl.text,
      };

      var response = await http.post(url, body: data);

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
    var url = Uri.parse('');

    try {
      var data = {
        "email": authEmailCtrl.text,
        "code": authCodeCtrl.text,
      };

      var response = await http.post(url, body: data);

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
    var url = Uri.parse('');

    try {
      var data = {
        "email": authEmailCtrl.text,
        "code": authCodeCtrl.text,
        "password": authPasswordCtrl.text,
      };

      var response = await http.post(url, body: data);

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
