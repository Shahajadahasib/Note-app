import 'dart:developer';
import 'dart:math';

import 'package:demo2/providers/note_provider.dart';
import 'package:demo2/screen/notes_pages.dart';
import 'package:demo2/screen/test.dart';
import 'package:demo2/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screen/addnote.dart';
import 'screen/note_detailes.dart';
import 'theme_data.dart';

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
        // context.read<NoteProvider>().getData;
        // log("mainpage");
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(
              context.watch<ThemeProvider>().isDarkMode, context),
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<NoteProvider>().getData;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          const Padding(
            padding: EdgeInsets.only(top: 3.0),
            child: Icon(Icons.search_outlined),
          ),
          const SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                context.read<ThemeProvider>().setDarkMode =
                    !context.read<ThemeProvider>().isDarkMode;
              },
              child: Icon(context.watch<ThemeProvider>().isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                "All notes",
                style: GoogleFonts.dancingScript(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 40,
                  ),
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Consumer<NoteProvider>(
                builder: (context, value, child) {
                  return value.data.isNotEmpty
                      ? MasonryGridView.count(
                          itemCount: value.data.length,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          // the number of columns
                          crossAxisCount: 3,
                          // vertical gap between two items
                          mainAxisSpacing: 4,
                          // horizontal gap between two items
                          crossAxisSpacing: 4,
                          itemBuilder: (context, index) {
                            print(value.data[index].toMap());
                            // display each item with a card
                            return GestureDetector(
                              onTap: () async {
                                print(value.data[index].id!);
                                context.read<NoteProvider>().viewnoteid =
                                    value.data[index].id!;
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NoteDetails(),
                                  ),
                                );
                              },
                              child: Card(
                                // Give each item a random background color
                                color: Color.fromARGB(
                                  Random().nextInt(256),
                                  Random().nextInt(256),
                                  Random().nextInt(256),
                                  Random().nextInt(256),
                                ),
                                key: ValueKey(value.data[index].id),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, left: 10),
                                      alignment: Alignment.topLeft,
                                      child: value.data[index].title != ''
                                          ? Text(
                                              value.data[index].title!,
                                              style: GoogleFonts.ebGaramond(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              'Title',
                                              style: GoogleFonts.islandMoments(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        value.data[index].description.length >
                                                40
                                            ? value.data[index].description
                                                .substring(0, 40)
                                            : value.data[index].description,
                                        style: GoogleFonts.notoSans(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                'No data',
                                style: GoogleFonts.robotoSlab(
                                  textStyle: TextStyle(
                                    fontSize: 30,

                                    color: context
                                            .watch<ThemeProvider>()
                                            .isDarkMode
                                        ? Color.fromARGB(255, 80, 73, 73)
                                        : Color.fromARGB(255, 234, 206, 204),
                                    fontWeight: FontWeight.w500,
                                    // backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNotes(),
            ),
          );
        },
        // backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}
