import 'package:flutter/material.dart';
import 'package:todo/models/my_user.dart';

class AuthProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
