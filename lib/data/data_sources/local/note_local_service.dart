import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'note_local_service.g.dart';

@DataClassName('Note')
class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get textNote => text()();
  TextColumn get importance => text()();
  TextColumn get makeBefore => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Notes])
class NoteLocalService extends _$NoteLocalService {
  NoteLocalService([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'note_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  Future<List<Note>> getAllNotes() async => select(notes).get();
  Future<bool> updateNote(Note entry) async {
    return update(notes).replace(entry);
  }

  Future<int> createNote(Note entry) async {
    return into(notes).insert(entry);
  }

  Future<bool> deleteNote(Note entry) async {
    final count = await delete(notes).delete(entry);
    return count > 0;
  }
}
