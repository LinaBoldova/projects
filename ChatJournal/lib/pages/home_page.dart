import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'create_event.dart';
import 'events_chats.dart';
import 'icons.dart';

GlobalKey<EventsListState> keyEventsList = GlobalKey();

class EventsList extends StatefulWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  EventsListState createState() => EventsListState();
}

class EventsListState extends State<EventsList> {
  final _errorTime = '24:00';
  List<Event> events = [
    Event(
      iconIndex: 1,
      title: 'Travel',
      notes: [
        Note(
          content: 'Hello World!',
          dateTime: DateTime.now(),
          rightHanded: false,
        ),
        Note(
          content: 'Please, no...!',
          dateTime: DateTime.now(),
        ),
      ],
    ),
    Event(
      iconIndex: 8,
      title: 'Work',
      notes: [],
    ),
    Event(
      iconIndex: 14,
      title: 'Sports',
      notes: [],
    ),
    Event(
      iconIndex: 4,
      title: 'Family',
      notes: [],
    )
  ];

  void updateLast() {
    setState(() {});
  }

  void addEvent({required int iconIndex, required String title}) {
    setState(
      () {
        events.add(
          Event(
            iconIndex: iconIndex,
            title: title,
            notes: [],
          ),
        );
      },
    );
  }

  void _deleteEvent(int index) {
    Navigator.pop(context);
    setState(
      () => events.removeAt(index),
    );
  }

  void editEvent(int index, String newTitle, int newIconIndex) {
    setState(() => events[index]
      ..title = newTitle
      ..iconIndex = newIconIndex);
  }

  void _options(int index) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(7),
        ),
      ),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.info_rounded),
              title: const Text('Info'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file_rounded),
              title: const Text('Pin/Unpin Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive_rounded),
              title: const Text('Archive Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_rounded),
              title: const Text('Edit page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CreateEvent(editingEventIndex: index,);
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_rounded),
              title: const Text('Delete Page'),
              onTap: () => _deleteEvent(index),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: events.length,
      itemBuilder: (context, index) => ListTile(
        //hoverColor: const Color.fromRGBO(216, 205, 176, 0.4),
        title: Text(events[index].title),
        subtitle: Text(
          events[index].lastNote.content,
          style: Theme.of(context).textTheme.bodyText1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Builder(
          builder: (context) => Icon(icons[events[index].iconIndex]),
        ),
        trailing: (events[index].lastNote.time == _errorTime)
            ? const SizedBox(
                width: 1,
              )
            : Text(events[index].lastNote.time),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatList(
                event: events[index],
              );
            },
          ),
        ),
        onLongPress: () => _options(index),
      ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: EventsList(
            key: keyEventsList,
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomNavigationBar _defaultBottomBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_rounded,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_task_rounded,
          ),
          label: 'Daily',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.map_rounded,
          ),
          label: 'Timeline',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.navigation_rounded,
          ),
          label: 'Explore',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
              ),
              onPressed: () {},
            );
          },
        ),
        title: Center(
          child: Text(
            widget.title,
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.brush_rounded,
                ),
                onPressed: () => (Theme.of(context).brightness == Brightness.light)
                    ? isLightTheme.add(false)
                    : isLightTheme.add(true),
              );
            },
          ),
        ],
      ),
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateEvent(editingEventIndex: -1,),
          ),
        ),
        child: const Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: _defaultBottomBar(),
    );
  }
}
