import 'package:flutter/material.dart';

abstract class RegisterNavigator {
  void showMyLoading();

  void hideMyLoading();

  void showMyMessage(String message, String title);

  void showMyToast(String message, Color color);

  void toastAction();
}
