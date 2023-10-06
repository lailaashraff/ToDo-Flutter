import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/components/custom_textformfield.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/models/my_user.dart';
import 'package:todo/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: 'laila');

  TextEditingController emailController =
      TextEditingController(text: 'jj@yahoo.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  TextEditingController confirmPasswordController =
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

  void register() async {
    if (formKey.currentState!.validate() == true) {
      //todo:show loading
      DialogUtils.showLoading(context, 'Loading...');

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            email: emailController.text,
            id: credential.user?.uid,
            name: nameController.text);
        await FirebaseUtils.addUserToFirestore(myUser);
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.updateUser(myUser);
        //todo:hide loading
        DialogUtils.hideLoading(context);

        //todo:show message
        DialogUtils.showMessage(context, 'Registered Successfully',
            title: 'Success', posActionName: 'Ok', posAction: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });

        print('registered successfuly');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        //todo:hide loading
        //todo:show message
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            'The password provided is too weak',
            title: 'Error',
            posActionName: 'Ok',
          );

          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            'The account already exists for that email.',
            title: 'Error',
            posActionName: 'Ok',
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        //todo:hide loading
        //todo:show message
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context,
          '${e.toString()}',
          title: 'Error',
          posActionName: 'Ok',
        );
        print(e.toString());
      }
    }
  }
}
