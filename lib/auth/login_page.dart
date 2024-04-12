import 'package:flutter/material.dart';

import '../constant/assets_path.dart';
import '../home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController loginID = TextEditingController();
  TextEditingController password = TextEditingController();
  String defaultID = "a";
  String defaultPassword = "111111";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff023034),
      body: ListView(children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Image.asset(
                  pizzaSlice,
                  width: double.maxFinite,
                ),
              ),
              const Text("Sign In",
                  style: TextStyle(
                    color: Color(0xffFECE02),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: loginID,
                  // keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                      hintText: "LogIn ID",
                      hintStyle: TextStyle(
                        color: Colors.white30
                      ),
                      counterText: "",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      border: OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffFECE02), width: 2),
                          borderRadius: BorderRadius.circular(15))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter LogIn ID';
                    } else if (loginID.text != defaultID) {
                      return "Please check your LogIn ID";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: password,
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white30),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      border: OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color:Color(0xffFECE02), width: 2),
                          borderRadius: BorderRadius.circular(15))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Password';
                    } else if (value.length < 6) {
                      return 'Password required at least 6 characters';
                    } else if (password.text != defaultPassword) {
                      return "Please check your Password";
                    }
                    return null;
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  }
                },
                child: Container(
                  width: double.maxFinite,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: Color(0xffFECE02),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text("Log In",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
