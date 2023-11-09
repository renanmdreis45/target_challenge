import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:target_technical_challenge/stores/note_store.dart';
import 'package:target_technical_challenge/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  @observable
  String newNote = "";

  @action
  void setNewNote(String value) => newNote = value;

  ObservableList<NoteStore> noteList = ObservableList<NoteStore>();

  late SharedPreferences sp;

  String NOTES_KEY = "NOTES_LIST";

  @action
  Future<void> addNote() async {
    noteList.insert(0, NoteStore(Note(title: newNote)));

    newNote = "";
  }

  @action
  void removeNote(int index) {
    noteList.removeAt(index);
  }
}
