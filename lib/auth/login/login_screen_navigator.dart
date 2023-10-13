import 'package:flutter/material.dart';

abstract class LoginNavigator {
  void showMyLoading();

  void hideMyLoading();

  void showMyMessage(String message, String title);

  void showMyToast(String message, Color color);

  void toastAction();
}
