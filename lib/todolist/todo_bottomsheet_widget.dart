import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add new task',
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
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter task title';
                        }
                      },
                      decoration:
                          InputDecoration(hintText: 'Enter your task title'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter  task description';
                        }
                      },
                      maxLines: 3,
                      decoration:
                          InputDecoration(hintText: 'Enter task description'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Select date',
                      style: Theme.of(context).textTheme.titleMedium,
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
                      'Add',
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
      selectedDate = DateFormat('dd/MM/yyyy').format(chosenDate);
    }
    setState(() {});
  }

  addTask() {
    if (_formKey.currentState?.validate() == true) {}
  }
}
