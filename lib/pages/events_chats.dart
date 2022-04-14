import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'home_page.dart';

import 'favorites.dart';

class Note {
  final DateTime _dateTime;
  String content;
  bool isFavorite = false;
  bool isSelected = false;
  final bool _rightHanded;

  Note({required dateTime, required this.content, rightHanded = true})
      : _dateTime = dateTime,
        _rightHanded = rightHanded;

  bool get rightHanded {
    return _rightHanded;
  }

  String get time {
    return DateFormat('kk:mm').format(_dateTime).toString();
  }
}

class Event {
  String title;
  List<Note> _notes;
  int iconIndex;

  Event({required this.iconIndex, required this.title, required List<Note> notes})
      : _notes = notes;

  List<Note> get notes {
    return _notes;
  }


  Note get lastNote {
    if (_notes.isEmpty) {
      return Note(
        dateTime: DateTime(2022),
        content: 'No events. Click to create one.',
      );
    }
    return _notes[_notes.length - 1];
  }
}

class DefaultBody extends StatelessWidget {
  final String title;

  const DefaultBody({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            height: 190,
            width: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).cardColor,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    'This is the page where you can track everything about $title!',
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    'Add your first event to $title page by entering some text )in the text box below and hitting the send button. Long tap the send button to align the event in opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}

class ChatList extends StatefulWidget {
  final Event event;

  const ChatList({Key? key, required this.event}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<int> _selected = [];
  bool _editingMode = false;
  bool _selectingMode = false;
  int? _editingIndex;
  late Event event = widget.event;
  final TextEditingController _noteController = TextEditingController();

  void _editNote(int index) {
    setState(
      () {
        _cancelSelectingMode();
        _noteController.clear();
        _noteController.text = event.notes[index].content;
        _editingMode = true;
        _editingIndex = index;
      },
    );
  }

  void _changeMark(List<int> indexes) {
    setState(
      () {
        for (var index in indexes) {
          (event.notes[index].isFavorite)
              ? event.notes[index].isFavorite = false
              : event.notes[index].isFavorite = true;
        }
      },
    );
  }

  void _addNote(Note newNote) {
    _noteController.clear();
    setState(() => event.notes.add(newNote));
  }

  void _cancelEditingMode() {
    setState(
      () {
        _noteController.clear();
        _editingMode = false;
        _editingIndex = null;
      },
    );
  }

  void _changeNote(String newContent, int index) {
    setState(
      () => event.notes[index].content = newContent,
    );
    _noteController.clear();
    _cancelEditingMode();
  }

  void _cancelSelectingMode() {
    for (var index in _selected) {
      event.notes[index].isSelected = false;
    }
    _selected.clear();
    setState(
      () => _selectingMode = false,
    );
  }

  void _checkSelectingMode(int index) {
    _cancelEditingMode();
    if (event.notes[index].isSelected) {
      _selected.remove(index);
      event.notes[index].isSelected = false;
    } else {
      _selected.add(index);
      event.notes[index].isSelected = true;
    }
    setState(
      () => (_selected.isNotEmpty) ? _selectingMode = true : _selectingMode = false,
    );
  }

  bool _sameFavoriteStatus() {
    for (int i = 0; i < _selected.length - 1; i++) {
      if (event.notes[_selected[i]].isFavorite != event.notes[_selected[i + 1]].isFavorite) {
        return false;
      }
    }
    return true;
  }

  void _returnBack() {
    keyEventsList.currentState?.updateLast();
    Navigator.pop(context);
  }

  Stack _noteField() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color:
                (Theme.of(context).brightness == Brightness.light) ? Colors.white : Colors.black87,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.bubble_chart_rounded,
                  ),
                  color: Theme.of(context).iconTheme.color,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    autofocus: false,
                    controller: _noteController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Write note...',
                      //hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                (_editingMode)
                    ? IconButton(
                        onPressed: _cancelEditingMode,
                        icon: const Icon(
                          Icons.cancel_rounded,
                        ),
                        color: Theme.of(context).iconTheme.color,
                      )
                    : const SizedBox(
                        width: 15,
                      ),
                GestureDetector(
                  child: const Icon(
                    Icons.send_rounded,
                  ),
                  onTap: () {
                    if (_noteController.text.isNotEmpty) {
                      (!_editingMode)
                          ? _addNote(
                              Note(
                                dateTime: DateTime.now(),
                                content: _noteController.text,
                                rightHanded: true,
                              ),
                            )
                          : _changeNote(_noteController.text, _editingIndex!);
                    } else if (_noteController.text.isEmpty && _editingMode) {
                      _cancelEditingMode();
                    }
                  },
                  onLongPress: () {
                    if (_noteController.text.isNotEmpty) {
                      (!_editingMode)
                          ? _addNote(
                              Note(
                                dateTime: DateTime.now(),
                                content: _noteController.text,
                                rightHanded: false,
                              ),
                            )
                          : _changeNote(
                              _noteController.text,
                              _editingIndex!,
                            );
                    } else if (_noteController.text.isEmpty && _editingMode) {
                      _cancelEditingMode();
                    }
                  },
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  AppBar _defaultAppBar() {
    return AppBar(
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(7),
      //   ),
      // ),
      //backgroundColor: const Color.fromRGBO(135, 148, 192, 1),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        //color: const Color.fromRGBO(28, 33, 53, 1),
        onPressed: () => _returnBack(),
      ),
      title: Expanded(
        child: Center(
          child: Text(
            event.title,
            // style: const TextStyle(
            //   color: Color.fromRGBO(28, 33, 53, 1),
            // ),
          ),
        ),
      ),
      actions: [
        Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.search_rounded,
                //color: Color.fromRGBO(28, 33, 53, 1),
              ),
              onPressed: () {},
            );
          },
        ),
        Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.star_rounded,
                //color: Color.fromRGBO(28, 33, 53, 1),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Favorites(
                    event: event,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  AppBar _modeAppBar() {
    return AppBar(
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(7),
      //   ),
      // ),
      // backgroundColor: const Color.fromRGBO(135, 148, 192, 1),
      leading: IconButton(
        icon: const Icon(Icons.cancel_rounded),
        //color: const Color.fromRGBO(28, 33, 53, 1),
        onPressed: _cancelSelectingMode,
      ),
      actions: [
        Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.copy_rounded,
                //color: Color.fromRGBO(28, 33, 53, 1),
              ),
              onPressed: _copyNotes,
            );
          },
        ),
        (_sameFavoriteStatus())
            ? Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.star_rounded,
                      //color: Color.fromRGBO(28, 33, 53, 1),
                    ),
                    onPressed: _addToFavorites,
                  );
                },
              )
            : const SizedBox(
                height: 0,
              ),
        (_selected.length == 1)
            ? Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.edit_rounded,
                      //color: Color.fromRGBO(28, 33, 53, 1),
                    ),
                    onPressed: () => _editNote(
                      _selected[0],
                    ),
                  );
                },
              )
            : const SizedBox(
                height: 0,
              ),
        Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.delete_rounded,
                //color: Color.fromRGBO(28, 33, 53, 1),
              ),
              onPressed: _deleteNotes,
            );
          },
        ),
      ],
    );
  }

  Color? _noteColor(int index) {
    if (Theme.of(context).brightness == Brightness.light) {
      if (event.notes[index].isSelected && _selectingMode == true) {
        return Colors.lightGreen[200];
      }
      return (event.notes[index].rightHanded ? Colors.grey.shade200 : Colors.blue[200]);
    } else if (event.notes[index].isSelected && _selectingMode == true) {
      return const Color.fromRGBO(165, 175, 118, 1);
    }
    return (event.notes[index].rightHanded
        ? Colors.white24
        : const Color.fromRGBO(196, 164, 107, 0.8));
  }

  void _deleteNotes() {
    _selected.sort();
    for (var i = _selected.length - 1; i > -1; i--) {
      event.notes.removeAt(_selected[i]);
    }
    setState(
      () {
        _selectingMode = false;
        _selected.clear();
      },
    );
  }

  void _addToFavorites() {
    _changeMark(_selected);
    _cancelSelectingMode();
  }

  void _copyNotes() {
    var copiedNotes = '';
    for (var index in _selected) {
      copiedNotes += event.notes[index].content;
      copiedNotes += '\n';
    }
    Clipboard.setData(
      ClipboardData(
        text: copiedNotes,
      ),
    );
    _cancelSelectingMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_selectingMode) ? _modeAppBar() : _defaultAppBar(),
      body: Column(
        children: [
          if (event.notes.isEmpty) DefaultBody(title: event.title),
          if (event.notes.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: event.notes.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (event.notes[index].rightHanded
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 200,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: _noteColor(index),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.notes[index].content,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  (event.notes[index].isSelected)
                                      ? const Icon(
                                          Icons.check_rounded,
                                          size: 20,
                                        )
                                      : const SizedBox(
                                          width: 0.2,
                                        ),
                                  Text(
                                    event.notes[index].time,
                                    style: const TextStyle(fontSize: 11),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  (event.notes[index].isFavorite)
                                      ? Icon(
                                          Icons.star_rounded,
                                          size: 20,
                                          color: (Theme.of(context).brightness == Brightness.light)
                                              ? const Color.fromRGBO(216, 205, 176, 0.9)
                                              : const Color.fromRGBO(252, 217, 131, 1),
                                        )
                                      : const SizedBox(
                                          width: 0.2,
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onLongPress: () => _editNote(index),
                    onDoubleTap: () => _changeMark([index]),
                    onTap: () => _checkSelectingMode(index),
                  );
                },
              ),
            ),
          _noteField(),
        ],
      ),
    );
  }
}
