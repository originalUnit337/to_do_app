// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_local_service.dart';

// ignore_for_file: type=lint
class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textNoteMeta = const VerificationMeta(
    'textNote',
  );
  @override
  late final GeneratedColumn<String> textNote = GeneratedColumn<String>(
    'text_note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importanceMeta = const VerificationMeta(
    'importance',
  );
  @override
  late final GeneratedColumn<String> importance = GeneratedColumn<String>(
    'importance',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _makeBeforeMeta = const VerificationMeta(
    'makeBefore',
  );
  @override
  late final GeneratedColumn<String> makeBefore = GeneratedColumn<String>(
    'make_before',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    textNote,
    importance,
    makeBefore,
    isCompleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('text_note')) {
      context.handle(
        _textNoteMeta,
        textNote.isAcceptableOrUnknown(data['text_note']!, _textNoteMeta),
      );
    } else if (isInserting) {
      context.missing(_textNoteMeta);
    }
    if (data.containsKey('importance')) {
      context.handle(
        _importanceMeta,
        importance.isAcceptableOrUnknown(data['importance']!, _importanceMeta),
      );
    } else if (isInserting) {
      context.missing(_importanceMeta);
    }
    if (data.containsKey('make_before')) {
      context.handle(
        _makeBeforeMeta,
        makeBefore.isAcceptableOrUnknown(data['make_before']!, _makeBeforeMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      textNote:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}text_note'],
          )!,
      importance:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}importance'],
          )!,
      makeBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}make_before'],
      ),
      isCompleted:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_completed'],
          )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final String id;
  final String textNote;
  final String importance;
  final String? makeBefore;
  final bool isCompleted;
  const Note({
    required this.id,
    required this.textNote,
    required this.importance,
    this.makeBefore,
    required this.isCompleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['text_note'] = Variable<String>(textNote);
    map['importance'] = Variable<String>(importance);
    if (!nullToAbsent || makeBefore != null) {
      map['make_before'] = Variable<String>(makeBefore);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      textNote: Value(textNote),
      importance: Value(importance),
      makeBefore:
          makeBefore == null && nullToAbsent
              ? const Value.absent()
              : Value(makeBefore),
      isCompleted: Value(isCompleted),
    );
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<String>(json['id']),
      textNote: serializer.fromJson<String>(json['textNote']),
      importance: serializer.fromJson<String>(json['importance']),
      makeBefore: serializer.fromJson<String?>(json['makeBefore']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'textNote': serializer.toJson<String>(textNote),
      'importance': serializer.toJson<String>(importance),
      'makeBefore': serializer.toJson<String?>(makeBefore),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  Note copyWith({
    String? id,
    String? textNote,
    String? importance,
    Value<String?> makeBefore = const Value.absent(),
    bool? isCompleted,
  }) => Note(
    id: id ?? this.id,
    textNote: textNote ?? this.textNote,
    importance: importance ?? this.importance,
    makeBefore: makeBefore.present ? makeBefore.value : this.makeBefore,
    isCompleted: isCompleted ?? this.isCompleted,
  );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      textNote: data.textNote.present ? data.textNote.value : this.textNote,
      importance:
          data.importance.present ? data.importance.value : this.importance,
      makeBefore:
          data.makeBefore.present ? data.makeBefore.value : this.makeBefore,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('textNote: $textNote, ')
          ..write('importance: $importance, ')
          ..write('makeBefore: $makeBefore, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, textNote, importance, makeBefore, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.textNote == this.textNote &&
          other.importance == this.importance &&
          other.makeBefore == this.makeBefore &&
          other.isCompleted == this.isCompleted);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<String> textNote;
  final Value<String> importance;
  final Value<String?> makeBefore;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.textNote = const Value.absent(),
    this.importance = const Value.absent(),
    this.makeBefore = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    required String textNote,
    required String importance,
    this.makeBefore = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       textNote = Value(textNote),
       importance = Value(importance);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<String>? textNote,
    Expression<String>? importance,
    Expression<String>? makeBefore,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (textNote != null) 'text_note': textNote,
      if (importance != null) 'importance': importance,
      if (makeBefore != null) 'make_before': makeBefore,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({
    Value<String>? id,
    Value<String>? textNote,
    Value<String>? importance,
    Value<String?>? makeBefore,
    Value<bool>? isCompleted,
    Value<int>? rowid,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      textNote: textNote ?? this.textNote,
      importance: importance ?? this.importance,
      makeBefore: makeBefore ?? this.makeBefore,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (textNote.present) {
      map['text_note'] = Variable<String>(textNote.value);
    }
    if (importance.present) {
      map['importance'] = Variable<String>(importance.value);
    }
    if (makeBefore.present) {
      map['make_before'] = Variable<String>(makeBefore.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('textNote: $textNote, ')
          ..write('importance: $importance, ')
          ..write('makeBefore: $makeBefore, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$NoteLocalService extends GeneratedDatabase {
  _$NoteLocalService(QueryExecutor e) : super(e);
  $NoteLocalServiceManager get managers => $NoteLocalServiceManager(this);
  late final $NotesTable notes = $NotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notes];
}

typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      required String id,
      required String textNote,
      required String importance,
      Value<String?> makeBefore,
      Value<bool> isCompleted,
      Value<int> rowid,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<String> id,
      Value<String> textNote,
      Value<String> importance,
      Value<String?> makeBefore,
      Value<bool> isCompleted,
      Value<int> rowid,
    });

class $$NotesTableFilterComposer
    extends Composer<_$NoteLocalService, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textNote => $composableBuilder(
    column: $table.textNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get makeBefore => $composableBuilder(
    column: $table.makeBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotesTableOrderingComposer
    extends Composer<_$NoteLocalService, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textNote => $composableBuilder(
    column: $table.textNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get makeBefore => $composableBuilder(
    column: $table.makeBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotesTableAnnotationComposer
    extends Composer<_$NoteLocalService, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get textNote =>
      $composableBuilder(column: $table.textNote, builder: (column) => column);

  GeneratedColumn<String> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get makeBefore => $composableBuilder(
    column: $table.makeBefore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$NoteLocalService,
          $NotesTable,
          Note,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (Note, BaseReferences<_$NoteLocalService, $NotesTable, Note>),
          Note,
          PrefetchHooks Function()
        > {
  $$NotesTableTableManager(_$NoteLocalService db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> textNote = const Value.absent(),
                Value<String> importance = const Value.absent(),
                Value<String?> makeBefore = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                textNote: textNote,
                importance: importance,
                makeBefore: makeBefore,
                isCompleted: isCompleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String textNote,
                required String importance,
                Value<String?> makeBefore = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion.insert(
                id: id,
                textNote: textNote,
                importance: importance,
                makeBefore: makeBefore,
                isCompleted: isCompleted,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$NoteLocalService,
      $NotesTable,
      Note,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (Note, BaseReferences<_$NoteLocalService, $NotesTable, Note>),
      Note,
      PrefetchHooks Function()
    >;

class $NoteLocalServiceManager {
  final _$NoteLocalService _db;
  $NoteLocalServiceManager(this._db);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
}
