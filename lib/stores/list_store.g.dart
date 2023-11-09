part of 'list_store.dart';

mixin _$ListStore on _ListStore, Store {
  final _$newNoteTitleAtom = Atom(name: '_ListStore.newNoteTitle');

  @override
  String get newNote {
    _$newNoteTitleAtom.reportRead();
    return super.newNote;
  }

  @override
  set newNote(String value) {
    _$newNoteTitleAtom.reportWrite(value, super.newNote, () {
      super.newNote = value;
    });
  }
  final _$addNoteAsyncAction = AsyncAction('_ListStore.addNote');

  @override
  Future<void> addNote() {
    return _$addNoteAsyncAction.run(() => super.addNote());
  }

  final _$_ListStoreActionController = ActionController(name: '_ListStore');


  @override
  void removeNote(int index) {
    final _$actionInfo =
        _$_ListStoreActionController.startAction(name: '_ListStore.removeNote');
    try {
      return super.removeNote(index);
    } finally {
      _$_ListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewNote(String value) {
    final _$actionInfo =
        _$_ListStoreActionController.startAction(name: '_ListStore.setNewNote');
    try {
      return super.setNewNote(value);
    } finally {
      _$_ListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newNote: ${newNote},
    ''';
  }
}
