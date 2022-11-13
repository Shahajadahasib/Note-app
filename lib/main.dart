import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/note_provider.dart';
import 'providers/theme_provider.dart';
import 'screen/notes_pages.dart';
import 'consts/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

ThemeProvider themeProvider = ThemeProvider();
checktheme() async {
  themeProvider.setDarkMode = await themeProvider.pref.getThemeData();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checktheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => themeProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => NoteProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Note',
          theme: Styles.themeData(
              context.watch<ThemeProvider>().isDarkMode, context),
          home: const HomePage(),
        );
      },
    );
  }
}
