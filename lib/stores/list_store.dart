import 'package:mobx/mobx.dart';
import 'package:target_technical_challenge/stores/note_store.dart';

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
    final allNotes = await db.todoNotes();
    noteList.addAll(allNotes.reversed);
  }

  @action
  Future<void> addNote() async{
    await db.insert(TodoNote(title: newNote));
    noteList.insert(0, NoteStore(TodoNote(title: newNote)));

    newNote = "";
  }
  
}