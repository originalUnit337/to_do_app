import 'dart:math';

import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:to_do_app/core/common/enums/importance.dart';
import 'package:to_do_app/data/api/model/database_version_model.dart';
import 'package:to_do_app/data/api/model/document_model.dart';
import 'package:to_do_app/data/api/model/note_model.dart';
import 'package:to_do_app/data/data_sources/remote/note_api_service.dart';
import 'package:to_do_app/data/mapper/note_mapper.dart';

import 'note_api_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  group('NoteApiService', () {
    late NoteApiService noteApiService;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      when(mockDio.options).thenReturn(BaseOptions());
      noteApiService = NoteApiService(mockDio);
    });
    test('getAllNotes returns CollectionModel<NoteModel>', () async {
      // Arrange
      final randomNotes = List.generate(5, (_) => generateRandomNote());
      final time = DateTime.now();
      final value = {
        'documents':
            randomNotes.map((note) {
              return <String, dynamic>{
                'name': note.id,
                'fields': <String, dynamic>{
                  'textNote': {'stringValue': note.textNote},
                  'importance': {'stringValue': note.importance.label},
                  'makeBefore':
                      note.makeBefore != null
                          ? {'stringValue': note.makeBefore?.toIso8601String()}
                          : {'nullValue': 'NULL_VALUE'},
                  'isCompleted': {'booleanValue': note.isCompleted},
                },
                'createTime': time.toIso8601String(),
                'updateTime': time.toIso8601String(),
              };
            }).toList(),
      };
      when(mockDio.fetch<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(data: value, requestOptions: RequestOptions()),
      );

      // Act
      final result = await noteApiService.getAllNotes();

      // Assert
      expect(result.data.documents, isA<List<DocumentModel<NoteModel>>>());
      expect(result.data.documents.length, equals(randomNotes.length));
    });

    test('update_note_success', () async {
      // Arrange
      final randomNote = generateRandomNote();
      final time = DateTime.now();

      final valueModel = NoteModel(
        id: randomNote.id,
        textNote: 'This note (${randomNote.id}) has been updated',
        importance: randomNote.importance,
      );

      final valueMap = <String, dynamic>{
        'name': valueModel.id,
        'fields': <String, dynamic>{
          'textNote': {'stringValue': valueModel.textNote},
          'importance': {'stringValue': valueModel.importance.label},
          'makeBefore':
              valueModel.makeBefore != null
                  ? {'stringValue': valueModel.makeBefore?.toIso8601String()}
                  : {'nullValue': 'NULL_VALUE'},
          'isCompleted': {'booleanValue': valueModel.isCompleted},
        },
        'createTime': time.toIso8601String(),
        'updateTime': time.toIso8601String(),
      };

      when(mockDio.fetch<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(data: valueMap, requestOptions: RequestOptions()),
      );

      // Act
      final result = await noteApiService.updateNote(randomNote.id, valueModel);

      // Assert
      expect(result.data, isA<DocumentModel<NoteModel>>());
      expect(result.data.fields, equals(valueModel));
    });

    test('create_note_success', () async {
      // Arrange
      final randomNote = generateRandomNote();
      final time = DateTime.now();

      final valueModel = NoteModel(
        id: randomNote.id,
        textNote: 'This note (${randomNote.id}) has been created',
        importance: randomNote.importance,
      );

      final valueMap = <String, dynamic>{
        'name': valueModel.id,
        'fields': <String, dynamic>{
          'textNote': {'stringValue': valueModel.textNote},
          'importance': {'stringValue': valueModel.importance.label},
          'makeBefore':
              valueModel.makeBefore != null
                  ? {'stringValue': valueModel.makeBefore?.toIso8601String()}
                  : {'nullValue': 'NULL_VALUE'},
          'isCompleted': {'booleanValue': valueModel.isCompleted},
        },
        'createTime': time.toIso8601String(),
        'updateTime': time.toIso8601String(),
      };

      when(mockDio.fetch<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(data: valueMap, requestOptions: RequestOptions()),
      );

      // Act
      final result = await noteApiService.createNote(
        'your_collection',
        valueModel,
      );

      // Assert
      expect(result.data, isA<DocumentModel<NoteModel>>());
      expect(result.data.fields, equals(valueModel));
    });

    test('delete_note_success', () async {
      when(mockDio.fetch<void>(any)).thenAnswer(
        (_) async => Response(
          data: null,
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'OK',
        ),
      );

      // Act
      final result = await noteApiService.deleteNote('id');

      // Assert
      expect(result.response.statusCode, equals(200));
    });

    test('get_database_version success', () async {
      // Arrange
      final time = DateTime.now();
      final databaseVersion = DatabaseVersionModel(time, 'id');
      final returnValue = {
        'documents': <Map<String, dynamic>>[
          {
            'name': '${databaseVersion.id}/db_version/',
            'fields': <String, dynamic>{
              'version': {
                'stringValue': databaseVersion.version.toIso8601String(),
              },
            },
            'createTime': time.toIso8601String(),
            'updateTime': time.toIso8601String(),
          },
        ],
      };
      when(mockDio.fetch<Map<String, dynamic>>(any)).thenAnswer(
        (_) async =>
            Response(data: returnValue, requestOptions: RequestOptions()),
      );

      // Act
      final result = await noteApiService.getDatabaseVersion();

      // Assert
      expect(
        result.data.documents,
        isA<List<DocumentModel<DatabaseVersionModel>>>(),
      );
    });

    test('update_database_version success', () async {
      // Arrange
      final time = DateTime.now();
      final databaseVersion = DatabaseVersionModel(time, 'id');
      final returnValue = <String, dynamic>{
        'name': '${databaseVersion.id}/db_version/',
        'fields': <String, dynamic>{
          'version': {'stringValue': databaseVersion.version.toIso8601String()},
        },
        'createTime': time.toIso8601String(),
        'updateTime': time.toIso8601String(),
      };
      when(mockDio.fetch<Map<String, dynamic>>(any)).thenAnswer(
        (_) async =>
            Response(data: returnValue, requestOptions: RequestOptions()),
      );

      // Act
      final result = await noteApiService.updateDatabaseVersion(
        databaseVersion.id,
        databaseVersion,
      );

      // Assert
      expect(result.data, isA<DocumentModel<DatabaseVersionModel>>());
    });

    test('create_database_version success', () async {
      // Arrange
      final time = DateTime.now();
      final databaseVersion = DatabaseVersionModel(time, 'id');
      final returnValue = <String, dynamic>{
        'name': '${databaseVersion.id}/db_version/',
        'fields': <String, dynamic>{
          'version': {'stringValue': databaseVersion.version.toIso8601String()},
        },
        'createTime': time.toIso8601String(),
        'updateTime': time.toIso8601String(),
      };
      when(mockDio.fetch<Map<String, dynamic>>(any)).thenAnswer(
        (_) async =>
            Response(data: returnValue, requestOptions: RequestOptions()),
      );

      // Act
      final result = await noteApiService.createDataBaseVersion(
        'collection_id',
        databaseVersion,
      );

      // Assert
      expect(result.data, isA<DocumentModel<DatabaseVersionModel>>());
    });

    test('delete_data_base_version success', () async {
      // Arrange

      when(mockDio.fetch<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: null,
          requestOptions: RequestOptions(),
          statusCode: 200,
        ),
      );

      // Act
      final result = await noteApiService.deleteDatabaseVersion('database_id');

      // Assert
      expect(result.response.statusCode, equals(200));
    });
  });
}

NoteModel generateRandomNote() {
  final id = Random().nextInt(100).toString();
  final importanceIntValue = Random().nextInt(Importance.values.length);
  late Importance importance;
  switch (importanceIntValue) {
    case 0:
      importance = Importance.no;
    case 1:
      importance = Importance.low;
    case 2:
      importance = Importance.high;
  }

  return NoteModel(
    id: '/notes/$id',
    textNote: 'This is note - $id',
    importance: importance,
  );
}
