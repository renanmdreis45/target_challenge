
part of 'note_store.dart';

mixin _$NoteStore on _NoteStoreBase, Store {


  final _$updateNoteAsyncAction = AsyncAction('_NoteStoreBase.updateNote');

  @override
  Future<void> updateNote(String newNote) {
    return _$updateNoteAsyncAction.run(() => super.updateNote(newNote));
  }

}