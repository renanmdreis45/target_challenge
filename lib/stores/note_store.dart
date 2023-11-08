import 'package:mobx/mobx.dart';
import 'package:target_technical_challenge/models/note_model.dart';

part 'note_store.g.dart';

class NoteStore = _NoteStoreBase with _$NoteStore;

abstract class _NoteStoreBase with Store {
  Note note;

  _NoteStoreBase(this.note);

  @action
  Future<void> updateNote(String newNote) async {
    note.title = newNote;
  }
}
