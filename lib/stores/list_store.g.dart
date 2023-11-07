part of 'list_store.dart';

mixin _$ListStore on _ListStore, Store {
  final _$newTodoTitleAtom = Atom(name: '_ListStore.newTodoTitle');

  @override
  String get newNote {
    _$newTodoTitleAtom.reportRead();
    return super.newNote;
  }

  @override
  set newNote(String value) {
    _$newTodoTitleAtom.reportWrite(value, super.newNote, () {
      super.newNote = value;
    });
  }

  final _$getListAsyncAction = AsyncAction('_ListStore.getList');

  @override
  Future<void> getList() {
    return _$getListAsyncAction.run(() => super.getList());
  }

  final _$addTodoAsyncAction = AsyncAction('_ListStore.addNote');

  @override
  Future<void> addTodo() {
    return _$addTodoAsyncAction.run(() => super.addNote());
  }

  final _$_ListStoreActionController = ActionController(name: '_ListStore');

  @override
  void setNewTodoTitle(String value) {
    final _$actionInfo = _$_ListStoreActionController.startAction(
        name: '_ListStore.setNewNote');
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
