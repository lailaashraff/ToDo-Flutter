import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/app_config_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.add_new_task,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectTaskDate();
                    },
                    child: Text(
                      selectedDate,
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge,
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
      selectedDate = DateFormat('dd/MM/yyyy').format(chosenDate);
    }
    setState(() {});
  }

  addTask() {
    if (_formKey.currentState?.validate() == true) {}
  }
}
