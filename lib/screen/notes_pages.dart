import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../providers/note_provider.dart';
import '../providers/theme_provider.dart';
import 'addnote.dart';
import 'note_detailes.dart';

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
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDeligate(),
                );
              },
              icon: const Icon(Icons.search)),
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
              padding: const EdgeInsets.only(left: 18.0),
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
                            // print(value.data[index].toMap());
                            // display each item with a card
                            return GestureDetector(
                              onTap: () async {
                                // print(value.data[index].id!);
                                context.read<NoteProvider>().viewnoteid =
                                    value.data[index].id!;
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const NoteDetails(),
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
                                        ? const Color.fromARGB(255, 80, 73, 73)
                                        : const Color.fromARGB(
                                            255, 234, 206, 204),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MySearchDeligate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          context.read<NoteProvider>().listData = [];
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              context.read<NoteProvider>().listData = [];
              close(context, null);
            }
            query = '';
          },
          icon: const Icon(Icons.clear),
        )
      ];

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Results',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: context.read<ThemeProvider>().isDarkMode
                ? const Color.fromARGB(255, 112, 101, 100)
                : const Color.fromARGB(255, 161, 152, 152),
          ),
        ),
        Expanded(
          child: context.watch<NoteProvider>().listData.isEmpty
              ? const Center(
                  child: Text(
                    'No search',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemCount: context.read<NoteProvider>().listData.length,
                  itemBuilder: (context, index) {
                    final suggestion =
                        context.read<NoteProvider>().listData[index];
                    return ListTile(
                        title: Text(suggestion.title!),
                        subtitle: Text(
                          suggestion.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () async {
                          context.read<NoteProvider>().viewnoteid =
                              suggestion.id!;
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NoteDetails(),
                            ),
                          );
                        });
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<NoteModel> search = query.isEmpty
        ? context.watch<NoteProvider>().data
        : context.read<NoteProvider>().listData =
            context.watch<NoteProvider>().data.where(
            (element) {
              return element.title!.contains(query);
            },
          ).toList();
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'Suggestions',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: context.read<ThemeProvider>().isDarkMode
                ? const Color.fromARGB(255, 112, 101, 100)
                : const Color.fromARGB(255, 161, 152, 152),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: search.length,
            itemBuilder: (context, index) {
              final suggestion = search[index];
              return ListTile(
                title: Text(
                  suggestion.title!,
                  style: const TextStyle(),
                ),
                subtitle: Text(
                  suggestion.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  query = suggestion.title!;
                  context.read<NoteProvider>().listData =
                      context.read<NoteProvider>().data.where(
                    (element) {
                      return element.title!.contains(query);
                    },
                  ).toList();

                  showResults(context);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
