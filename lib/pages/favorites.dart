import 'package:flutter/material.dart';
import 'events_chats.dart';

class Favorites extends StatefulWidget {
  final Event event;

  const Favorites({Key? key, required this.event}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late final _favorites = favoriteNotes(widget.event.notes);

  List<Note> favoriteNotes(List<Note> allNotes) {
    var favoriteNotes = <Note>[];
    for (var note in allNotes) {
      if (note.isFavorite) favoriteNotes.add(note);
    }
    return favoriteNotes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(7),
        //   ),
        // ),
        //backgroundColor: const Color.fromRGBO(135, 148, 192, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          //color: const Color.fromRGBO(28, 33, 53, 1),
          onPressed: () => Navigator.pop(context),
        ),
        title: Expanded(
          child: Center(
            child: Text(
              widget.event.title,
              // style: const TextStyle(
              //   //color: Color.fromRGBO(28, 33, 53, 1),
              // ),
            ),
          ),
        ),
        actions: [
          Icon(
            Icons.star_rounded,
            color: (Theme.of(context).brightness == Brightness.light)
                ? const Color.fromRGBO(216, 205, 176, 0.9)
                : const Color.fromRGBO(252, 217, 131, 1),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          if (_favorites.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _favorites.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment:
                            (_favorites[index].rightHanded ? Alignment.topLeft : Alignment.topRight),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 200,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (Theme.of(context).brightness == Brightness.light)
                                ? (_favorites[index].rightHanded
                                    ? Colors.grey.shade200
                                    : Colors.blue[200])
                                : (_favorites[index].rightHanded
                                    ? Colors.white24
                                    : const Color.fromRGBO(196, 164, 107, 0.8)),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _favorites[index].content,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  (_favorites[index].isSelected)
                                      ? const Icon(
                                          Icons.check_rounded,
                                          size: 20,
                                          //color: Colors.black,
                                        )
                                      : const SizedBox(
                                          width: 0.2,
                                        ),
                                  Text(
                                    _favorites[index].time,
                                    style: const TextStyle(fontSize: 11),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  (_favorites[index].isFavorite)
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
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
