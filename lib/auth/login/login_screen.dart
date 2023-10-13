import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login/login_screen_navigator.dart';
import 'package:todo/auth/login/login_screen_view_model.dart';
import 'package:todo/auth/register/register_screen.dart';
import 'package:todo/components/custom_textformfield.dart';

import '../../dialog_utils.dart';
import '../../home_screen.dart';
import '../../providers/auth_provider.dart';
import '../../toast_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginScreenViewModel viewModel = LoginScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    viewModel.authProvider = Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
                              .pushReplacementNamed(RegisterScreen.routeName);
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
      ),
    );
  }

  void login() async {
    if (formKey.currentState!.validate() == true) {
      viewModel.login(emailController.text, passwordController.text);
    }
  }

  @override
  void hideMyLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showMyLoading() {
    DialogUtils.showLoading(context, 'Loading...');
  }

  @override
  void showMyMessage(String message, String title) {
    DialogUtils.showMessage(context, message,
        title: title, posActionName: 'ok');
  }

  @override
  void showMyToast(String message, Color color) {
    // TODO: implement showMyToast
    ToastUtils.showToast(toastMessage: message, toastColor: color);
  }

  @override
  void toastAction() {
    // TODO: implement toastAction
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}
