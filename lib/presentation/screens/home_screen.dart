import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/domain/model/note.dart';
import 'package:to_do_app/navigation/app_routes.dart';
import 'package:to_do_app/presentation/ui_kit/font/app_font_style.dart';
import 'package:to_do_app/presentation/ui_kit/palette/app_palette.dart';

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
    final currentPalette = AppPalette.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(AppRoutes.addNoteName);
        },
        child: Icon(Icons.add, color: currentPalette.colorWhite),
        backgroundColor: currentPalette.colorBlue,
      ),
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
              title: Text(
                AppLocalizations.of(context)!.myNotes,
                style: AppFontStyle.largeTitle,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            sliver: DecoratedSliver(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                    color: Colors.black.withAlpha(12),
                  ),
                  BoxShadow(color: Colors.black.withAlpha(6), blurRadius: 2),
                ],
                color: currentPalette.backSecondary,
                borderRadius: BorderRadius.circular(8),
              ),
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
                        padding: EdgeInsets.only(left: 24),
                        child: Icon(Icons.check, color: Colors.white),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        // ? отнять 8 из-за падинга текста
                        horizontal: 16 - 8,
                        vertical: 12 - 8,
                      ),
                      child: ListTile(
                        // ? У текста свой падинг 8 пискелей во все стороны хз откуда
                        title: Text(
                          '${noteItems[index].textNote} #$index',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.body,
                        ),
                        leading: Checkbox(value: false, onChanged: (value) {}),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.info_outline,
                            color: currentPalette.labelTertiary,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
