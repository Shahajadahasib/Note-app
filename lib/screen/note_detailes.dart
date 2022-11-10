// import 'dart:developer';

// import 'package:demo2/models/note_model.dart';
// import 'package:demo2/providers/note_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import '../theme/theme_provider.dart';

// class NoteDetails extends StatefulWidget {
//   final int noteId;
//   const NoteDetails({super.key, required this.noteId});

//   @override
//   State<NoteDetails> createState() => _MyWidgetState();
// }

// TextEditingController textcontroller = TextEditingController();
// TextEditingController discripcontroller = TextEditingController();

// class _MyWidgetState extends State<NoteDetails> {
//   // late NoteModel note;
//   bool isLoading = false;
//   @override
//   void initState() {
//     context.read<NoteProvider>().readNote(widget.noteId);
//     discripcontroller.text =
//         context.read<NoteProvider>().single_data.description;
//     textcontroller.text = context.read<NoteProvider>().single_data.title!;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final values = context.read<NoteProvider>().single_data;

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         actions: [
//           InkWell(
//             onTap: () {
//               context.read<ThemeProvider>().setDarkMode =
//                   !context.read<ThemeProvider>().isDarkMode;
//             },
//             child: Icon(context.watch<ThemeProvider>().isDarkMode
//                 ? Icons.dark_mode
//                 : Icons.light_mode),
//           ),
//         ],
//         centerTitle: true,
//         title: Text('Note'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       var data = NoteModel(
//                         id: widget.noteId,
//                         title: textcontroller.text.trim(),
//                         description: discripcontroller.text.trim(),
//                         createTime: DateTime.now(),
//                       );
//                       context.read<NoteProvider>().update(data);
//                       // Navigator.pop(context);
//                       log(discripcontroller.text);
//                     },
//                     child: ListView(
//                       children: [
//                         TextField(
//                           style: const TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.w400),
//                           controller: textcontroller,
//                           decoration: InputDecoration(
//                             hintText: 'Title',
//                             hintStyle: GoogleFonts.lobster(
//                               textStyle: TextStyle(
//                                 fontSize: 20,
//                               ),
//                             ),
//                             border:
//                                 OutlineInputBorder(borderSide: BorderSide.none),
//                           ),
//                         ),
//                         // Text(
//                         //   "Write down your note here",
//                         //   style: GoogleFonts.kolkerBrush(
//                         //     textStyle: TextStyle(fontSize: 30),
//                         //   ),
//                         // ),
//                         Expanded(
//                           child: TextField(
//                             maxLines: 20,
//                             showCursor: false,
//                             style: const TextStyle(fontSize: 16),
//                             controller: discripcontroller,
//                             decoration: InputDecoration(
//                               hintText: "Write down your note here",
//                               hintStyle: GoogleFonts.lobster(
//                                 textStyle: TextStyle(fontSize: 30),
//                               ),
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide.none),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
