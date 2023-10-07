import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/toast_utils.dart';

import '../providers/auth_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  String title = '';
  String description = '';
  final _formKey = GlobalKey<FormState>();
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.add_new_task,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Form(
            key: _formKey,
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!.enter_task_title;
                        }
                      },
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.enter_task_title,
                        //hintStyle: Theme.of(context).textTheme.titleSmall
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!.enter_task_desc;
                        }
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enter_task_desc,
                        //hintStyle: Theme.of(context).textTheme.titleSmall
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      AppLocalizations.of(context)!.select_date,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectTaskDate();
                    },
                    child: Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addTask();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.add,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  selectTaskDate() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );

    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }

  addTask() {
    if (_formKey.currentState?.validate() == true) {
      //todo:show loading
      DialogUtils.showLoading(context, 'Loading...');
      Task task =
          Task(title: title, description: description, dateTime: selectedDate);
      var authProvider = Provider.of<AuthProvider>(context, listen: false);

      FirebaseUtils.addTaskToFirestore(task, authProvider.currentUser!.id!)
          .then((value) {
        //todo: hide loading
        DialogUtils.hideLoading(context);
        listProvider.getTasksFromFireStore(authProvider.currentUser!.id!);
        Navigator.pop(context);
        ToastUtils.showToast(
            toastMessage: 'Task added successfully.',
            toastColor: MyTheme.greenColor);
        // DialogUtils.showMessage(context, 'To do added successfully',
        //     posActionName: 'ok');
      });
    }
  }
}
