import 'package:flutter/material.dart';
import 'package:todo/auth/register/register_screen.dart';
import 'package:todo/components/custom_textformfield.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(10)),
                    child: Text('Login',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
                      },
                      child: Text('Sign Up',
                          style: Theme.of(context).textTheme.displayMedium),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void login() {
    if (formKey.currentState!.validate() == true) {}
  }
}
