import 'package:mobx/mobx.dart';

part 'note_store.g.dart';

class NoteStore = _NoteStoreBase with _$NoteStore;

abstract class _NoteStoreBase with Store {
  TodoNote todo;

  _NoteStoreBase(this.todo);

  @observable
  bool done = false;

  @action
  Future<void> updateNote() async {
    done = !done;
    todo.done == 1 ? todo.done = 0 : todo.done = 1;

    await db.update(todo);
  }
}