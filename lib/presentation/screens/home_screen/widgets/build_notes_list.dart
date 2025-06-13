import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_bloc.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_event.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_state.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/info_note_screen.dart';
import 'package:to_do_app/presentation/ui_kit/font/app_font_style.dart';
import 'package:to_do_app/presentation/ui_kit/palette/app_palette.dart';

class BuildNotesList extends StatelessWidget {
  final List<NoteEntity> noteItems;
  //final ValueNotifier<bool> showCompletedNotifier = ValueNotifier(true);
  final String? message;
  final bool showCompleted;
  const BuildNotesList({
    required this.noteItems,
    required this.showCompleted,
    this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentPalette = AppPalette.of(context);
    //bool showCompleted = true;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          actions: [
            IconButton(
              icon: Icon(
                showCompleted ? Icons.visibility_off : Icons.visibility,
                color: currentPalette.colorBlue,
              ),
              onPressed: () {
                BlocProvider.of<HomeScreenBloc>(
                  context,
                ).add(ToggleShowCompleted());
              },
            ),
          ],
          expandedHeight: 140,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              AppLocalizations.of(context)?.myNotes ?? 'My notes',
              style: AppFontStyle.largeTitle,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
            child: Padding(
              padding: const EdgeInsets.only(right: 24, left: 60),
              child: Text(
                '${AppLocalizations.of(context)?.completed ?? 'Completed'} — ${noteItems.where((e) {
                  return e.isCompleted;
                }).length}',
                style: AppFontStyle.body.copyWith(
                  color: currentPalette.labelTertiary,
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
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
              delegate: SliverChildBuilderDelegate(
                childCount: noteItems.length,
                (context, index) {
                  if (!showCompleted && noteItems[index].isCompleted) {
                    return const SizedBox.shrink();
                  }
                  return Dismissible(
                    key: UniqueKey(),
                    direction:
                        showCompleted
                            ? DismissDirection.endToStart
                            : DismissDirection.horizontal,
                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Icon(Icons.check, color: Colors.white),
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        BlocProvider.of<HomeScreenBloc>(
                          context,
                        ).add(ToggleNoteCompletion(noteItems[index]));
                        BlocListener<HomeScreenBloc, HomeScreenState>(
                          listener: (context, state) {
                            if (state is NotesLoaded) {
                              if (state.message != null) {
                                final snackBar = SnackBar(
                                  //TODO Add localization
                                  content: Text(
                                    message ?? 'Something went wrong',
                                  ),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'Close',
                                    onPressed: () {},
                                  ),
                                );

                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                              }
                            }
                          },
                        );

                        //noteItems[index].isCompleted = true;
                      } else {}
                    },
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                      title: Row(
                        children: [
                          if (noteItems[index].importance == '2')
                            Text(
                              '!! ',
                              style: TextStyle(
                                color: currentPalette.colorRed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (noteItems[index].importance == '1')
                            Text(
                              '↓ ',
                              style: TextStyle(
                                color: currentPalette.colorGray,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              noteItems[index].textNote ?? 'Empty',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  noteItems[index].isCompleted
                                      ? AppFontStyle.body.copyWith(
                                        color: currentPalette.labelTertiary,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor:
                                            currentPalette.labelTertiary,
                                      )
                                      : AppFontStyle.body,
                            ),
                          ),
                        ],
                      ),
                      leading: Checkbox(
                        value: noteItems[index].isCompleted ? true : false,
                        onChanged: (value) {},
                        side: BorderSide(
                          color:
                              noteItems[index].importance == '2'
                                  ? currentPalette.colorRed
                                  : currentPalette.supportSeparator,
                          width: 2,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    InfoNoteScreen(note: noteItems[index]),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: currentPalette.labelTertiary,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      InfoNoteScreen(note: noteItems[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
