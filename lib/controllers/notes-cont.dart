import 'package:get/get.dart';
import 'package:goto/models/task-model.dart';
import 'package:hive/hive.dart';

class NotesController extends GetxController {
  RxList<NoteModel> allNotes = <NoteModel>[].obs;
  RxList<NoteModel> pinnedNotes = <NoteModel>[].obs;
  RxList<NoteModel> unpinnedNotes = <NoteModel>[].obs;

  late Box<NoteModel> notesBox;

  @override
  void onInit() {
    super.onInit();
    notesBox = Hive.box<NoteModel>('notes');
    loadNotes();
  }

  void loadNotes() {
    final notes = notesBox.values.toList();
    allNotes.value = notes;
    _separateNotes(notes);
  }

  void addNote(NoteModel note) {
    notesBox.add(note);
    loadNotes();
  }

  void updateNote(int index, NoteModel updatedNote) {
    notesBox.putAt(index, updatedNote);
    loadNotes();
  }

  void deleteNote(int index) {
    notesBox.deleteAt(index);
    loadNotes();
  }

  void togglePin(NoteModel note) {
    final index = allNotes.indexOf(note);
    if (index != -1) {
      note.isPinned = !note.isPinned;
      note.save();
      loadNotes();
    }
  }

  void toggleComplete(int index) {
    final note = allNotes[index];
    note.isCompleted = !note.isCompleted;
    note.save();
    loadNotes();
  }

  void _separateNotes(List<NoteModel> notes) {
    pinnedNotes.value = notes.where((n) => n.isPinned).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    unpinnedNotes.value = notes.where((n) => !n.isPinned).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  void clearAllNotes() async {
    await notesBox.clear();
    loadNotes();
  }

  int getNoteIndex(NoteModel note) {
    return allNotes.indexOf(note);
  }
}