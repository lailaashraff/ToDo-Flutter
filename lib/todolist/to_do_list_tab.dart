import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/todolist/task_widget.dart';

import '../providers/auth_provider.dart';

class ToDoList extends StatefulWidget {
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (listProvider.taskList.isEmpty) {
      listProvider.getTasksFromFireStore(authProvider.currentUser!.id!);
    }
    return Column(
      children: [
        CalendarTimeline(
          initialDate: listProvider.selectedDate,
          firstDate: DateTime.now().subtract(
            Duration(days: 365),
          ),
          lastDate: DateTime.now().add(
            Duration(days: 365),
          ),
          onDateSelected: (date) {
            listProvider.changeSelectDate(date, authProvider.currentUser!.id!);
          },
          leftMargin: 20,
          monthColor: provider.isDarkMode()
              ? MyTheme.blackColor
              : Theme.of(context).primaryColor,
          dayColor: MyTheme.blackColor,
          activeDayColor: provider.isDarkMode() ? Colors.black : Colors.white,
          activeBackgroundDayColor: MyTheme.primaryLight,
          dotsColor: provider.isDarkMode() ? Colors.black : Colors.white,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskWidget(
                task: listProvider.taskList[index],
              );
            },
            itemCount: listProvider.taskList.length,
          ),
        )
      ],
    );
  }
}
