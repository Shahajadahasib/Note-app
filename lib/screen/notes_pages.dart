// import 'package:demo2/providers/note_provider.dart';
// import 'package:demo2/screen/addnote.dart';
// import 'package:demo2/screen/note_detailes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:provider/provider.dart';

// class NotesPage extends StatefulWidget {
//   const NotesPage({super.key});

//   @override
//   State<NotesPage> createState() => _NotesPageState();
// }

// class _NotesPageState extends State<NotesPage> {
//   @override
//   Widget build(BuildContext context) {
//     context.read<NoteProvider>().getData;
//     return Scaffold(
//       body: SafeArea(
//         child: Consumer<NoteProvider>(
//           builder: (context, value, child) {
//             return value.isloading
//                 ? CircularProgressIndicator()
//                 : value.data.isEmpty
//                     ? const Text("No Notes")
//                     : MasonryGridView.count(
//                         crossAxisCount: 4,
//                         itemCount: value.data.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () async {
//                               await Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                   builder: (context) => NoteDetails(
//                                     noteId: context
//                                         .read<NoteProvider>()
//                                         .data[index]
//                                         .id!,
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: ListTile(
//                               title: Text(value.data[index].title!),
//                             ),
//                           );
//                         },
//                         // crossAxisCount: notes.length,
//                         mainAxisSpacing: 4,
//                       );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => const AddNotes(),
//             ),
//           );
//         },
//         backgroundColor: Colors.red,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
