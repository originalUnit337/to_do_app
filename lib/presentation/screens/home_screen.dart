import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/domain/model/note.dart';
import 'package:to_do_app/presentation/ui%20kit/font/app_font_style.dart';

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            //backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.visibility_off),
                onPressed: () {},
              ),
            ],
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                AppLocalizations.of(context)!.myNotes,
                style: AppFontStyle.largeTitle,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(childCount: 20, (
                context,
                index,
              ) {
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
                      style: AppFontStyle.body,
                      //style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    leading: Checkbox(value: false, onChanged: (value) {}),
                    trailing: IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {},
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
