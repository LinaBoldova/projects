import 'package:flutter/material.dart';

import 'icons.dart';
import 'home_page.dart';

class CreateEvent extends StatefulWidget {
  int editingEventIndex = -1;
  CreateEvent({Key? key, required this.editingEventIndex}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  bool editingMode = false;
  int _tmpIconIndex = -1;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.editingEventIndex != -1) {
      _tmpIconIndex = keyEventsList.currentState!.events[widget.editingEventIndex].iconIndex;
      _textController.text = keyEventsList.currentState!.events[widget.editingEventIndex].title;
      editingMode = true;
    }
  }

  void _editEvent() {
    if (widget.editingEventIndex != -1 && _textController.text.isNotEmpty && _tmpIconIndex != -1) {
      keyEventsList.currentState?.editEvent(
        widget.editingEventIndex!,
        _textController.text,
        _tmpIconIndex,
      );
      Navigator.pop(context);
    }
  }

  void _createEvent() {
    if (_textController.text.isNotEmpty && _tmpIconIndex != -1) {
      keyEventsList.currentState?.addEvent(
        title: _textController.text,
        iconIndex: _tmpIconIndex,
      );
      _textController.clear();
      Navigator.pop(context);
    }
  }

  GridView _iconsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 13,
        mainAxisSpacing: 13,
        childAspectRatio: 1.5,
      ),
      itemCount: icons.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 40,
              maxWidth: 40,
            ),
            alignment: Alignment.center,
            child: Icon(
              icons[index],
              size: 30,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
            decoration: BoxDecoration(
              color: (_tmpIconIndex == index)
                  ? Theme.of(context).focusColor
                  : Theme.of(context).bottomAppBarColor,
              shape: BoxShape.circle,
            ),
          ),
          onTap: () => setState(
            () {
              _tmpIconIndex = index;
            },
          ),
        );
      },
    );
  }

  Stack _nameField() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
            height: 60,
            width: double.infinity,
            color:
                (Theme.of(context).brightness == Brightness.light) ? Colors.white : Colors.black87,
            child: Expanded(
              child: TextField(
                autofocus: false,
                controller: _textController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Write name...',
                  //hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.only(left: 12),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.pop(context),
                color: Theme.of(context).appBarTheme.iconTheme?.color,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Text(
                    'Create a new page',
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 40,
                ),
                child: SizedBox(
                  width: Theme.of(context).iconTheme.size,
                ),
              ),
            ],
          ),
          _nameField(),
          Expanded(
            child: _iconsGrid(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: const Color.fromRGBO(216, 205, 176, 0.9),
        onPressed: () => editingMode ? _editEvent() : _createEvent(),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
