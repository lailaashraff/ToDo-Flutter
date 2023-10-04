import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/todolist/edit_task_widget.dart';

import 'auth/login/login_screen.dart';
import 'auth/register/register_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.disableNetwork();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppConfigProvider>(
          create: (_) => AppConfigProvider(),
        ),
        ChangeNotifierProvider<ListProvider>(
          create: (_) => ListProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      locale: Locale(provider.appLanguage),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      initialRoute: LoginScreen.routeName,
      themeMode: provider.appTheme,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTask.routeName: (context) => EditTask(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen()
      },
    );
  }
}
