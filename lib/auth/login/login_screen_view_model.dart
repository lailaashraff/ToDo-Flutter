import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/auth/login/login_screen_navigator.dart';

import '../../firebase_utils.dart';
import '../../my_theme.dart';
import '../../providers/auth_provider.dart';

class LoginScreenViewModel extends ChangeNotifier {
  late AuthProvider authProvider;
  late LoginNavigator navigator;

  Future<void> login(String email, String password) async {
    navigator.showMyLoading();

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //todo:hide loading
      var user = await FirebaseUtils.readUserData(credential.user?.uid ?? '');
      //user authenticated but not found in firebase
      if (user == null) {
        return;
      }
      //var authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.updateUser(user);
      navigator.hideMyLoading();

      //todo:show message
      navigator.showMyToast('Logged in Successfully.', MyTheme.primaryLight);
      navigator.toastAction();
      // ToastUtils.showToast(
      //     toastMessage: 'Logged in Successfully.',
      //     toastColor: MyTheme.primaryLight);
      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // DialogUtils.showMessage(context, 'Login Successfully',
      //     title: 'Success', posActionName: 'Ok', posAction: () {
      //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // });

      print('login successfully');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator.hideMyLoading();
        navigator.showMyMessage('No user found for that email.', 'Error');
        // DialogUtils.showMessage(
        //   context,
        //   'No user found for that email.',
        //   title: 'Error',
        //   posActionName: 'Ok',
        // );

        print('error firebaseAuth user: ${e.toString()}');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator.hideMyLoading();
        navigator.showMyMessage(
            'Wrong password provided for that user.', 'Error');
        // DialogUtils.showMessage(
        //   context,
        //   'Wrong password provided for that user.',
        //   title: 'Error',
        //   posActionName: 'Ok',
        // );
        print('error firebaseAuth pass: ${e.toString()}');
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      navigator.hideMyLoading();
      navigator.showMyMessage(e.toString(), 'Error');
      // DialogUtils.showMessage(
      //   context,
      //   '${e.toString()}',
      //   title: 'Error',
      //   posActionName: 'Ok',
      // );
      print('in second catch');
      print(e.toString());
    }
  }
}
