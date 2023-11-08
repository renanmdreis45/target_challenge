import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:target_technical_challenge/stores/list_store.dart';
import 'package:target_technical_challenge/stores/login_store.dart';

class ListScreen extends StatefulWidget {
  static String route = "/list";
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<ListScreen> {
  ListStore _listStore = ListStore();

  final myController = TextEditingController();
  final fieldController = TextEditingController();

  @override
  void initState() {
    _listStore.getList();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.teal.shade600,
              Colors.cyan.shade900,
            ],
          )),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context)!.size.width,
                      height: 300,
                      color: Colors.white,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: _listStore.noteList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final note = _listStore.noteList[index];

                          String? title = note.note.title;

                          return ListTile(
                            title: SizedBox(
                              height: 50,
                              width: 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: fieldController,
                                      onSubmitted: (String str) {
                                        fieldController.clear();
                                        note.updateNote(str);
                                      },
                                      decoration: InputDecoration(
                                          hintText: title,
                                          filled: true,
                                          fillColor: Colors.white,
                                          // contentPadding: EdgeInsets.only(
                                          //     left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          suffixIcon: const Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                            size: 32,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                      onPressed: () =>
                                          _listStore.removeNote(note),
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 32,
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      )),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: _listStore.setNewNote,
                  onSubmitted: (String str) {
                    print("entrou");
                    if (_listStore.newNote != '') {
                      myController.clear();
                      _listStore.addNote();
                    }
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Digite seu texto',
                      hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w900),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  'Política de privacidade',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ));
}
