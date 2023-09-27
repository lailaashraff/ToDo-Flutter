import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';

import '../firebase_utils.dart';
import '../models/task.dart';
import '../providers/app_config_provider.dart';
import '../providers/list_provider.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'edit-task-screen';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  DateTime selectedDate = DateTime.now();

  // String title = '';
  // String description = '';
  final _formKey = GlobalKey<FormState>();
  late Task args;
  late ListProvider listProvider;
  late Task task = Task(
    title: _titlecontroller.text,
    description: _desccontroller.text,
    dateTime: DateTime.now(),
  );
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _desccontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Task;

    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    if (_titlecontroller.text.isEmpty && _desccontroller.text.isEmpty) {
      _titlecontroller.text = args.title!;
      _desccontroller.text = args.description!;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: provider.isDarkMode() ? MyTheme.darkBlack : MyTheme.whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.editTask,
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
                        controller: _titlecontroller,
                        // onChanged: (text) {
                        //   title = text;
                        // },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .enter_task_title;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: args.title,
                            hintStyle: Theme.of(context).textTheme.titleSmall),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextFormField(
                        controller: _desccontroller,
                        // onChanged: (text) {
                        //   description = text;
                        // },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .enter_task_desc;
                          }
                        },
                        maxLines: 3,
                        decoration: InputDecoration(
                            hintText: args.description,
                            hintStyle: Theme.of(context).textTheme.titleSmall),
                      ),
                    ),
                    Spacer(),
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
                        '${args.dateTime?.day}/${args.dateTime?.month}/${args.dateTime?.year}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: ElevatedButton(
                        onPressed: () {
                          editTask();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.saveChanges,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
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

  editTask() {
    if (_formKey.currentState?.validate() == true) {
      task = Task(
          title: _titlecontroller.text,
          description: _desccontroller.text,
          dateTime: selectedDate,
          id: args.id);
      FirebaseUtils.updateTaskInFirestore(task)
          .timeout(Duration(milliseconds: 500), onTimeout: () {
        print('To do updated successfully');
        listProvider.getTasksFromFireStore();
      });
      setState(() {});
    }
  }
}
