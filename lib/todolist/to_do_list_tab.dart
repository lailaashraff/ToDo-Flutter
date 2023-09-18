import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/provider/app_config_provider.dart';

import 'add_task_widget.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(
            Duration(days: 365),
          ),
          lastDate: DateTime.now().add(
            Duration(days: 365),
          ),
          onDateSelected: (date) {},
          leftMargin: 20,
          monthColor: provider.isDarkMode()
              ? MyTheme.blackColor
              : Theme
              .of(context)
              .primaryColor,
          dayColor: MyTheme.blackColor,
          activeDayColor: provider.isDarkMode() ? Colors.black : Colors.white,
          activeBackgroundDayColor: MyTheme.primaryLight,
          dotsColor: provider.isDarkMode() ? Colors.black : Colors.white,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return AddTaskWidget();
            },
            itemCount: 20,
          ),
        )
      ],
    );
  }
}
