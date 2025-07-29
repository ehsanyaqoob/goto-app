// import 'package:get/get.dart';
// import 'package:goto/models/task-model.dart';
// import 'package:hive/hive.dart';

// class NotesController extends GetxController {
//   RxList<TaskModel> allNotes = <TaskModel>[].obs;
//   RxList<TaskModel> pinnedNotes = <TaskModel>[].obs;
//   RxList<TaskModel> unpinnedNotes = <TaskModel>[].obs;

//   late Box<TaskModel> notesBox;

//   @override
//   void onInit() {
//     super.onInit();
//     notesBox = Hive.box<TaskModel>('notes');
//     loadNotes();
//   }

//   void loadNotes() {
//     final notes = notesBox.values.toList();
//     allNotes.value = notes;
//     _separateNotes(notes);
//   }

//   void addNote(TaskModel note) {
//     notesBox.add(note);
//     loadNotes();
//   }

//   void updateNote(int index, TaskModel updatedNote) {
//     notesBox.putAt(index, updatedNote);
//     loadNotes();
//   }

//   void deleteNote(int index) {
//     notesBox.deleteAt(index);
//     loadNotes();
//   }

//   void togglePin(TaskModel note) {
//     final index = allNotes.indexOf(note);
//     if (index != -1) {
//       note.isPinned = !note.isPinned;
//       note.save();
//       loadNotes();
//     }
//   }

//   void toggleComplete(int index) {
//     final note = allNotes[index];
//     note.isCompleted = !note.isCompleted;
//     note.save();
//     loadNotes();
//   }

//   void _separateNotes(List<TaskModel> notes) {
//     pinnedNotes.value = notes.where((n) => n.isPinned).toList()
//       ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
//     unpinnedNotes.value = notes.where((n) => !n.isPinned).toList()
//       ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
//   }

//   void clearAllNotes() async {
//     await notesBox.clear();
//     loadNotes();
//   }

//   int getNoteIndex(TaskModel note) {
//     return allNotes.indexOf(note);
//   }
// }
