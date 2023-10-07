import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';

class DialogUtils {
  static void showLoading(BuildContext context, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text(message),
              ],
            ),
            contentTextStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: MyTheme.blackColor),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
    BuildContext context,
    String message, {
    String title = 'Title',
    String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
          ),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionName,
          ),
        ),
      );
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            title: Text(title),
            contentTextStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: MyTheme.blackColor),
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Theme.of(context).primaryColor),
            actions: actions,
          );
        });
  }
}
