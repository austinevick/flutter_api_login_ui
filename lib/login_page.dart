import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_login/shared_service.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';
import 'login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final url = 'https://evisitbackenapi.herokuapp.com/api/v1/auth/signin';
  var client = http.Client();
  bool isLoading = false;

  login(LoginModel model) async {
    var response = await client.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toMap()));
    if (response.statusCode == 200) {
      await SharedService().setLoginDetails(loginModel(response.body));
      return true;
    } else {
      return false;
    }
  }

  validate() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.purple[900],
          body: Column(
            children: [
              const SizedBox(height: 15),
              const Text('Sign into your account',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text(
                  'Sign into your Settl account and enjoy endless possibilities',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 75),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.3,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          TextFormField(
                              cursorColor: Colors.black,
                              cursorWidth: 1,
                              validator: (v) =>
                                  v!.isEmpty ? 'Please enter your email' : null,
                              controller: email,
                              decoration: const InputDecoration(
                                hintText: 'Phone number',
                              )),
                          const SizedBox(height: 12),
                          TextFormField(
                              cursorColor: Colors.black,
                              cursorWidth: 1,
                              validator: (v) => v!.isEmpty
                                  ? 'Please enter your password'
                                  : null,
                              controller: password,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                              )),
                          const SizedBox(height: 30),
                          MaterialButton(
                            onPressed: () {
                              if (validate()) {
                                setState(() => isLoading = true);
                              }
                              final model = LoginModel(
                                  email: email.text, password: password.text);
                              login(model).then((response) {
                                setState(() => isLoading = false);

                                if (response) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => const HomePage()),
                                      (route) => false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Invalid Credentials')));
                                }
                              });
                            },
                            color: Colors.purple[900],
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                            height: 50,
                            minWidth: 280,
                            child: isLoading
                                ? const Center(
                                    child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ))
                                : const Text('Sign in',
                                    style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
