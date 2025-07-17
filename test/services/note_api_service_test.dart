import 'dart:math';

import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:to_do_app/core/common/enums/importance.dart';
import 'package:to_do_app/data/api/model/document_model.dart';
import 'package:to_do_app/data/api/model/note_model.dart';
import 'package:to_do_app/data/data_sources/remote/note_api_service.dart';

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
      expect(
        result.data.documents.length,
        equals(randomNotes.length),
      ); // Check the length
    });

    test('update_note_success', () async {
      final randomNote = generateRandomNote();

      when(noteApiService.updateNote(randomNote.id, randomNote));
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
