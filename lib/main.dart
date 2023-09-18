import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project2/home/edit_task_screen.dart';
import 'package:project2/home/home_screen.dart';
import 'package:project2/my_theme.dart';
import 'package:project2/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: ((context) => AppConfigProvider()), child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTaskScreen.routeName: (context) => EditTaskScreen(),
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appTheme,
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
