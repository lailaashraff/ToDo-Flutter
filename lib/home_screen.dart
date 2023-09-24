import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/provider/app_config_provider.dart';
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
  String title = 'fixed';

  @override
  Widget build(BuildContext context) {
    // if (title == '') {
    //   initializeTitle();
    // }
    var provider = Provider.of<AppConfigProvider>(context);
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
          selectedIndex == 0
              ? AppLocalizations.of(context)!.app_title
              : AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: provider.isDarkMode() ? MyTheme.darkBlack : MyTheme.whiteColor,
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
              icon: Icon(Icons.list),
              label: AppLocalizations.of(context)!.app_title,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings,
            ),
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
        context: context,
        builder: (context) => Container(child: AddTaskBottomSheet()));
  }

  initializeTitle() {
    title = AppLocalizations.of(context)!.app_title;
  }
}
