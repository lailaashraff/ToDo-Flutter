import 'package:flutter/material.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/components/custom_textformfield.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/images/signIn.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.7,
                ),
                CustomTextFormField(
                  label: 'Username',
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  controller: nameController,
                ),
                CustomTextFormField(
                    label: 'Email Address',
                    keyBoardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter an email';
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    }),
                CustomTextFormField(
                    label: 'Password',
                    obscureText: true,
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter a password';
                      }
                      if (text.length < 6) {
                        return 'Please should be at least 6 characters';
                      }
                      return null;
                    }),
                CustomTextFormField(
                    label: 'Confirm Password',
                    obscureText: true,
                    controller: confirmPasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter confirmation password';
                      }
                      if (text != passwordController.text) {
                        return 'Please enter a matching password';
                      }
                      return null;
                    }),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(10)),
                    child: Text('Register',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Text('Already have an account? Login.'),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void register() {
    if (formKey.currentState!.validate() == true) {}
  }
}
