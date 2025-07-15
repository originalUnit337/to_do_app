import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/core/common/enums/importance.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/navigation/app_routes.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_bloc.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_event.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_state.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/info_note_screen.dart';
import 'package:to_do_app/presentation/ui_kit/font/app_font_style.dart';
import 'package:to_do_app/presentation/ui_kit/palette/app_palette.dart';

class NotesList extends StatelessWidget {
  final List<NoteEntity> noteItems;
  final String? message;
  final bool showCompleted;
  const NotesList({
    required this.noteItems,
    required this.showCompleted,
    this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentPalette = AppPalette.of(context);
    //bool showCompleted = true;

    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state is NotesLoaded) {
          if (state.isUpdated != null) {
            final snackBar = SnackBar(
              content: Text(
                state.isUpdated == true
                    ? AppLocalizations.of(context)?.data_updated ??
                        'Successfully updated'
                    : 'Something went wrong',
              ),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state.isSync != null) {
            final snackBar = SnackBar(
              content: Text(
                state.isSync == true
                    ? AppLocalizations.of(context)?.sync_success ??
                        'Successfully syncronized'
                    : AppLocalizations.of(context)?.sync_failed ??
                        'Syncronization failed',
              ),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      child: CustomScrollView(
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
                  context.read<HomeScreenBloc>().add(ToggleShowCompleted());
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
                          context.read<HomeScreenBloc>().add(
                            ToggleNoteCompletion(noteItems[index]),
                          );
                        } else {
                          context.read<HomeScreenBloc>().add(
                            DeleteNoteEvent(noteItems[index]),
                          );
                        }
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
                            if (noteItems[index].importance == Importance.high)
                              Text(
                                '!! ',
                                style: TextStyle(
                                  color: currentPalette.colorRed,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (noteItems[index].importance == Importance.low)
                              Text(
                                '↓ ',
                                style: TextStyle(
                                  color: currentPalette.colorGray,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            Expanded(
                              child: Text(
                                noteItems[index].textNote,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    noteItems[index].isCompleted
                                        ? AppFontStyle.body.copyWith(
                                          color: currentPalette.labelTertiary,
                                          decoration:
                                              TextDecoration.lineThrough,
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
                          onChanged: (value) {
                            context.read<HomeScreenBloc>().add(
                              ToggleNoteCompletion(noteItems[index]),
                            );
                          },
                          side: BorderSide(
                            color:
                                noteItems[index].importance == Importance.high
                                    ? currentPalette.colorRed
                                    : currentPalette.supportSeparator,
                            width: 2,
                          ),
                        ),
                        onTap: () async {
                          final result =
                              await GoRouter.of(context).pushNamed(
                                    AppRoutes.infoNote.name,
                                    extra: noteItems[index],
                                  )
                                  as NoteEntity?;
                          if (result != null) {
                            noteItems[index] = result;
                            if (context.mounted) {
                              // context.read<HomeScreenBloc>().add(
                              //   RefreshNotesEvent(noteItems),
                              // );
                              context.read<HomeScreenBloc>().add(
                                const GetAllNotesEvent(),
                              );
                            }
                          }
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
      ),
    );
  }
}
