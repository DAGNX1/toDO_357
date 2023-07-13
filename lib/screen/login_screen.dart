import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase/firebase_fuction.dart';
import 'package:to_do/screen/home_layout.dart';
import 'package:to_do/screen/regester_screen.dart';

import '../provider/my_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = false;
  var formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome back!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                  if (value.isEmpty) {
                    return "Please enter email";
                  } else if (!emailValid) {
                    return "Please enter valid email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.red, fontSize: 15),
                  hintText: 'Email',
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: isObscure,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value.length < 6) {
                    return 'Must be more than 6 charater';
                  }
                },
                controller: passwordController,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.red, fontSize: 15),
                  hintText: 'password',
                  labelText: 'password',
                    suffixIcon: IconButton(
                        icon: Icon(
                            isObscure ?  Icons.visibility_off:Icons.visibility ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        }),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.7,
                            MediaQuery.of(context).size.height * 0.1,
                          )),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          FireBaseFunction.login(
                              emailController.text, passwordController.text,
                              () {
                            prov.initUser();
                            Navigator.pushReplacementNamed(
                                context, HomeLayout.routeName);
                          }, (message) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Auth Error"),
                                    content: Text(message),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Ok"),
                                      )
                                    ],
                                  );
                                });
                          });
                        }
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Text(
                            "Login",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_outlined)
                        ],
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Forgot password?",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: const Text(
                          "Create New Account",
                          style: TextStyle(fontSize: 15),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void disposed() {
    emailController.dispose();
    passwordController.dispose();
  }
}
