import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/auth/register/register_screen.dart';
import 'package:todo/components/custom_textformfield.dart';

import '../../dialog_utils.dart';
import '../../home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'jj@yahoo.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

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

  void login() async {
    if (formKey.currentState!.validate() == true) {
      DialogUtils.showLoading(context, 'Loading...');

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        //todo:hide loading
        DialogUtils.hideLoading(context);

        //todo:show message
        DialogUtils.showMessage(context, 'Login Successfully',
            title: 'Success', posActionName: 'Ok', posAction: () {
          Navigator.pushNamed(context, HomeScreen.routeName);
        });

        print('login successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            'No user found for that email.',
            title: 'Error',
            posActionName: 'Ok',
          );

          print('error firebaseAuth user: ${e.toString()}');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            'Wrong password provided for that user.',
            title: 'Error',
            posActionName: 'Ok',
          );
          print('error firebaseAuth pass: ${e.toString()}');
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context,
          '${e.toString()}',
          title: 'Error',
          posActionName: 'Ok',
        );
        print('in second catch');
        print(e.toString());
      }
    }
  }
}
