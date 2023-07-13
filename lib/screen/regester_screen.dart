
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase/firebase_fuction.dart';
import 'package:to_do/screen/home_layout.dart';

import '../provider/my_provider.dart';

class RegisterScreen extends  StatefulWidget {
  static const String routeName = "RegisterScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formkey = GlobalKey<FormState>();
  bool isObscure = true;
  var emailController = TextEditingController();

  var nameController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.red, fontSize: 15),
                    hintText: 'Name',
                    labelText: 'Your Name',
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
                  controller: emailController,
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
                            isObscure ?  Icons.visibility_off:Icons.visibility),
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
                            FireBaseFunction.createAccount(
                                emailController.text, passwordController.text,
                                () {
                              prov.initUser();
                              Navigator.pushNamed(
                                  context, HomeLayout.routeName);
                            }, nameController.text);
                          }
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 60,
                            ),
                            Text(
                              "Register",
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  void disposed() {
    emailController.dispose();
    passwordController.dispose();
  }
}
