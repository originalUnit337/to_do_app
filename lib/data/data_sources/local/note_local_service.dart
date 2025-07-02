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
  DateTimeColumn get updateTime => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DatabaseVersion')
class DatabaseVersions extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get version => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Notes, DatabaseVersions])
class NoteLocalService extends _$NoteLocalService {
  NoteLocalService([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(databaseVersions);
      }
    },
  );

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
    final updatedNote = entry.copyWith(updateTime: DateTime.now());
    final result = await update(notes).replace(updatedNote);
    if (result) {
      await setDatabaseVersion(DateTime.now());
    }
    return result;
  }

  Future<int> createNote(Note entry) async {
    final createdNote = entry.copyWith(updateTime: DateTime.now());
    final result = await into(notes).insert(createdNote);
    await setDatabaseVersion(DateTime.now());
    return result;
  }

  Future<bool> deleteNote(Note entry) async {
    final count = await delete(notes).delete(entry);
    if (count > 0) {
      await setDatabaseVersion(DateTime.now());
    }
    return count > 0;
  }

  Future<void> setDatabaseVersion(DateTime version) async {
    try {
      await (delete(databaseVersions)..where((v) => v.id.equals(1))).go();
      await into(
        databaseVersions,
      ).insert(DatabaseVersion(id: 1, version: version));
    } on Exception {
      await into(
        databaseVersions,
      ).insert(DatabaseVersion(id: 1, version: version));
    }
  }

  Future<DatabaseVersion> getDatabaseVersion() async =>
      select(databaseVersions).getSingle();
}
