import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_technical_challenge/models/note_model.dart';
import 'package:target_technical_challenge/stores/list_store.dart';
import 'package:target_technical_challenge/stores/login_store.dart';
import 'package:target_technical_challenge/stores/note_store.dart';

class ListScreen extends StatefulWidget {
  static String route = "/list";
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<ListScreen> {
  ListStore _listStore = ListStore();
  late SharedPreferences sp;

  String NOTES_KEY = "NOTES_LIST";

  final fieldController = TextEditingController();
  late FocusNode textFocusNode;
  int selectedIndex = -1;

  getSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntoSp() {
    List<String> notesListString = _listStore.noteList
        .map((note) => jsonEncode(note.note.toJson()))
        .toList();

    sp.setStringList(NOTES_KEY, notesListString);
  }

  readFromSp() {
    List<String>? notesListString = sp.getStringList(NOTES_KEY);

    if (notesListString != null) {
      final notes = notesListString
          .map((note) => Note.fromJson(json.decode(note)))
          .toList();

      final allNotes = notes.map((note) => NoteStore(note));

      _listStore.noteList.addAll(allNotes);
    }

    setState(() {});
  }

  @override
  void initState() {
    getSharedPreferences();
    textFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    fieldController.dispose();
    textFocusNode.dispose();
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
                                    child: Text(
                                      title!,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        fieldController.text = title;
                                        textFocusNode.requestFocus();
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 32,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _listStore.removeNote(index);
                                        });

                                        saveIntoSp();
                                      },
                                      icon: const Icon(
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
                  focusNode: textFocusNode,
                  controller: fieldController,
                  onChanged: _listStore.setNewNote,
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          //
                          String note = fieldController.text.trim();
                          if (note.isNotEmpty) {
                            setState(() {
                              fieldController.text = '';
                              _listStore.addNote();
                            });
                          }
                          //
                        },
                        child: const Text('Adicionar', style: TextStyle(color: Colors.green),)),
                    ElevatedButton(
                        onPressed: () {
                          //
                          String note = fieldController.text.trim();
                          if (note.isNotEmpty) {
                            setState(() {
                              _listStore.noteList[selectedIndex]
                                  .updateNote(note);
                              selectedIndex = -1;
                              fieldController.text = '';
                            });

                            saveIntoSp();
                          }
                          //
                        },
                        child: const Text('Atualizar', style: TextStyle(color: Colors.green),)),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Política de privacidade',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ));
}
