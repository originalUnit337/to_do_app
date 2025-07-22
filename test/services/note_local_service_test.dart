import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/core/common/enums/importance.dart';
import 'package:to_do_app/data/data_sources/local/note_local_service.dart';

void main() {
  group('NoteLocalService', () {
    late NoteLocalService noteLocalService;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      noteLocalService = NoteLocalService(NativeDatabase.memory());
    });

    tearDown(() async {
      await noteLocalService.close();
    });

    test('createNote should return rowId', () async {
      // Arrange
      final note = Note(
        id: '1',
        textNote: 'Test note text',
        importance: Importance.low.label,
        isCompleted: false,
        updateTime: DateTime.now(),
      );

      // Act
      final result = await noteLocalService.createNote(note);

      // Assert
      expect(result, 1);
    });

    test('getAllNotes should return List<Note>', () async {
      // Arrange
      final note = Note(
        id: '1',
        textNote: 'Test note text',
        importance: Importance.low.label,
        isCompleted: false,
        updateTime: DateTime.now(),
      );

      await noteLocalService.createNote(note);

      // Act
      final result = await noteLocalService.getAllNotes();

      // Assert
      expect(result.length, 1);
      expect(result.first.id, '1');
      expect(result.first.textNote, 'Test note text');
    });

    test('updateNote should return bool (success or not)', () async {
      // Arrange
      final note = Note(
        id: '1',
        textNote: 'Test note text',
        importance: Importance.low.label,
        isCompleted: false,
        updateTime: DateTime.now(),
      );

      await noteLocalService.createNote(note);

      final updatedNote = note.copyWith(textNote: 'This not has been updated');

      // Act
      final resultTrue = await noteLocalService.updateNote(updatedNote);

      // Assert
      expect(resultTrue, true);

      // Act
      final resultFalse = await noteLocalService.updateNote(
        note.copyWith(id: 'not gonna find such id'),
      );

      // Assert
      expect(resultFalse, false);
    });

    test('deleteNote should return bool (success or not) ', () async {
      // Arrange
      final note = Note(
        id: '1',
        textNote: 'Test note text',
        importance: Importance.low.label,
        isCompleted: false,
        updateTime: DateTime.now(),
      );

      await noteLocalService.createNote(note);

      // Act
      final resultTrue = await noteLocalService.deleteNote(note);

      // Assert
      expect(resultTrue, true);

      // Act
      final resultFalse = await noteLocalService.deleteNote(
        note.copyWith(id: 'not gonna find such id'),
      );

      // Assert
      expect(resultFalse, false);
    });

    test(
      'setDatabaseVersion should delete previous version and set a new one',
      () async {
        // Arrange
        final time1 = DateTime(1984);
        final time2 = DateTime(2000);

        // Act
        await noteLocalService.setDatabaseVersion(time1);
        final result1 = await noteLocalService.getDatabaseVersion();

        // Assert
        expect(result1, isA<DatabaseVersion>());
        expect(result1.version, time1);

        // Act
        await noteLocalService.setDatabaseVersion(time2);
        final result2 = await noteLocalService.getDatabaseVersion();

        // Assert
        expect(result2, isA<DatabaseVersion>());
        expect(result2.version, time2);
      },
    );

    test('getDatabaseVErsion should return DatabaseVersion', () async {
      // Arrange
      final time = DateTime(2000);
      await noteLocalService.setDatabaseVersion(time);

      // Act
      final result = await noteLocalService.getDatabaseVersion();

      // Assert
      expect(result, isA<DatabaseVersion>());
      expect(result.version, time);
    });
  });
}
