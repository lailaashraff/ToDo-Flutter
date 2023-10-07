import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/todolist/edit_task_widget.dart';

import '../models/task.dart';
import '../providers/auth_provider.dart';
import '../toast_utils.dart';

class TaskWidget extends StatefulWidget {
  Task task;

  TaskWidget({required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  //bool isDone = false;
  late AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const BehindMotion(),

          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              onPressed: (context) {
                FirebaseUtils.deleteTask(
                        widget.task, authProvider.currentUser!.id!)
                    .then((value) {
                  listProvider
                      .getTasksFromFireStore(authProvider.currentUser!.id!);
                  ToastUtils.showToast(
                      toastMessage: 'Task deleted successfully.',
                      toastColor: MyTheme.redColor);
                });
                setState(() {});
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            print('tappeddd');
            Navigator.pushNamed(context, EditTask.routeName,
                arguments: widget.task);
          },
          child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: provider.isDarkMode()
                    ? MyTheme.darkBlack
                    : MyTheme.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.01,
                    color: widget.task.isDone!
                        ? MyTheme.greenColor
                        : MyTheme.primaryLight,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.task.title ?? '',
                            style: widget.task.isDone!
                                ? Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: MyTheme.greenColor)
                                : Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.task.description ?? '',
                              style: Theme.of(context).textTheme.titleSmall),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        onTapCompleteTask(widget.task).then((value) {
                          listProvider.getTasksFromFireStore(
                              authProvider.currentUser!.id!);
                          //ToastUtils.showToast(toastMessage: 'Good job on completing your task !', toastColor: MyTheme.greenColor);
                        });
                        setState(() {});
                      },
                      child: widget.task.isDone!
                          ? Text(
                        AppLocalizations.of(context)!.done,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: MyTheme.greenColor),
                      )
                          : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                          MediaQuery.of(context).size.width * 0.05,
                          vertical:
                          MediaQuery.of(context).size.height * 0.009,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.primaryLight,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: MyTheme.whiteColor,
                        ),
                        // ),
                      ))
                ],
              )),
        ),
      ),
    );
  }

  Future<void> onTapCompleteTask(Task task) {
    return FirebaseUtils.getTaskCollection(authProvider.currentUser!.id!)
        .doc(task.id)
        .update({'isDone': true});
  }
}
