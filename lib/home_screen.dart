import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/auth_provider.dart';
import 'package:todo/providers/list_provider.dart';
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
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);

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
              ? '${AppLocalizations.of(context)!.app_title} '
              // '${authProvider.currentUser!.name}'
              : AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                listProvider.taskList = [];
                authProvider.currentUser = null;
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              icon: Icon(Icons.login_outlined))
        ],
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
}
