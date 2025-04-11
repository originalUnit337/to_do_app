import 'package:flutter/material.dart';
import 'package:to_do_app/domain/model/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> noteItems = List.generate(
    20,
    (item) => Note(
      textNote:
          'Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обрезается текст $item',
      importance: '0',
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.visibility_off),
                onPressed: () {},
              ),
            ],
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Мои дела'),
              background: Container(color: Colors.blueAccent),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Dismissible(
                key: Key(noteItems[index].textNote),
                background: Container(
                  color: Colors.green,
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    '${noteItems[index].textNote} #$index',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    //style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  leading: Checkbox(value: false, onChanged: (value) {}),
                  trailing: IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {},
                  ),
                ),
              );
            }, childCount: 20),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
