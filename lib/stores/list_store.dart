import 'package:mobx/mobx.dart';
import 'package:target_technical_challenge/stores/note_store.dart';
import 'package:target_technical_challenge/models/note_model.dart';
part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  @observable
  String newNote = "";

  @action
  void setNewNote(String value) => newNote = value;

  ObservableList<NoteStore> noteList = ObservableList<NoteStore>();

  @action
  Future<void> getList() async {
    // final allNotes = await db.todoNotes();
  }

  @action
  Future<void> addNote() async {
    // await db.insert(Note(title: newNote));
    noteList.insert(0, NoteStore(Note(title: newNote)));

    newNote = "";
  }

  @action
  void removeNote(NoteStore note) {
    noteList.removeWhere((x) => x == note);
  }
}
