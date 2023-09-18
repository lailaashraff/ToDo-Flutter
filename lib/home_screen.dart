import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/settings/settings_tab.dart';
import 'package:todo/todolist/to_do_list_tab.dart';
import 'package:todo/todolist/todo_bottomsheet_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(width: 4, color: MyTheme.whiteColor),
        ),
        onPressed: () {
          showAddTaskBottomSheet();
          setState(() {});
        },
        child: Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(
          'To Do List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;

            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: 'To Do List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    ToDoList(),
    SettingsTab(),
  ];

  showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskBottomSheet());
  }
}
