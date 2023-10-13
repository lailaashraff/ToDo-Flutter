import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/auth/register/register_navigator.dart';

import '../../firebase_utils.dart';
import '../../models/my_user.dart';
import '../../my_theme.dart';
import '../../providers/auth_provider.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  late AuthProvider authProvider;
  late RegisterNavigator navigator;

  Future<void> register(String email, String password, String name) async {
    navigator.showMyLoading();

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser myUser =
          MyUser(email: email, id: credential.user?.uid, name: name);
      await FirebaseUtils.addUserToFirestore(myUser);
      //var authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.updateUser(myUser);
      //todo:hide loading
      navigator.hideMyLoading();

      //todo:show message
      navigator.showMyToast('Registered Successfully.', MyTheme.primaryLight);
      navigator.toastAction();
      // ToastUtils.showToast(
      //     toastMessage: 'Registered Successfully.',
      //     toastColor: MyTheme.primaryLight);
      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // DialogUtils.showMessage(context, 'Registered Successfully',
      //     title: 'Success', posActionName: 'Ok', posAction: () {
      //   Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // });

      print('registered successfully');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      //todo:hide loading
      //todo:show message
      if (e.code == 'weak-password') {
        navigator.hideMyLoading();
        navigator.showMyMessage('The password provided is too weak', 'Error');
        // DialogUtils.showMessage(
        //   context,
        //   'The password provided is too weak',
        //   title: 'Error',
        //   posActionName: 'Ok',
        // );

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator.hideMyLoading();
        navigator.showMyMessage(
            'The account already exists for that email.', 'Error');
        // DialogUtils.showMessage(
        //   context,
        //   'The account already exists for that email.',
        //   title: 'Error',
        //   posActionName: 'Ok',
        // );
        print('The account already exists for that email.');
      }
    } catch (e) {
      //todo:hide loading
      //todo:show message
      navigator.hideMyLoading();
      navigator.showMyMessage(e.toString(), 'Error');
      // DialogUtils.showMessage(
      //   context,
      //   '${e.toString()}',
      //   title: 'Error',
      //   posActionName: 'Ok',
      // );
      print(e.toString());
    }
  }
}
