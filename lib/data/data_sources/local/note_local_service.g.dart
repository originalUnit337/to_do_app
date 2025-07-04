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
  static const VerificationMeta _updateTimeMeta = const VerificationMeta(
    'updateTime',
  );
  @override
  late final GeneratedColumn<DateTime> updateTime = GeneratedColumn<DateTime>(
    'update_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    textNote,
    importance,
    makeBefore,
    isCompleted,
    updateTime,
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
    if (data.containsKey('update_time')) {
      context.handle(
        _updateTimeMeta,
        updateTime.isAcceptableOrUnknown(data['update_time']!, _updateTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
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
      updateTime:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}update_time'],
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
  final DateTime updateTime;
  const Note({
    required this.id,
    required this.textNote,
    required this.importance,
    this.makeBefore,
    required this.isCompleted,
    required this.updateTime,
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
    map['update_time'] = Variable<DateTime>(updateTime);
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
      updateTime: Value(updateTime),
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
      updateTime: serializer.fromJson<DateTime>(json['updateTime']),
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
      'updateTime': serializer.toJson<DateTime>(updateTime),
    };
  }

  Note copyWith({
    String? id,
    String? textNote,
    String? importance,
    Value<String?> makeBefore = const Value.absent(),
    bool? isCompleted,
    DateTime? updateTime,
  }) => Note(
    id: id ?? this.id,
    textNote: textNote ?? this.textNote,
    importance: importance ?? this.importance,
    makeBefore: makeBefore.present ? makeBefore.value : this.makeBefore,
    isCompleted: isCompleted ?? this.isCompleted,
    updateTime: updateTime ?? this.updateTime,
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
      updateTime:
          data.updateTime.present ? data.updateTime.value : this.updateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('textNote: $textNote, ')
          ..write('importance: $importance, ')
          ..write('makeBefore: $makeBefore, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    textNote,
    importance,
    makeBefore,
    isCompleted,
    updateTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.textNote == this.textNote &&
          other.importance == this.importance &&
          other.makeBefore == this.makeBefore &&
          other.isCompleted == this.isCompleted &&
          other.updateTime == this.updateTime);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<String> textNote;
  final Value<String> importance;
  final Value<String?> makeBefore;
  final Value<bool> isCompleted;
  final Value<DateTime> updateTime;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.textNote = const Value.absent(),
    this.importance = const Value.absent(),
    this.makeBefore = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    required String textNote,
    required String importance,
    this.makeBefore = const Value.absent(),
    this.isCompleted = const Value.absent(),
    required DateTime updateTime,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       textNote = Value(textNote),
       importance = Value(importance),
       updateTime = Value(updateTime);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<String>? textNote,
    Expression<String>? importance,
    Expression<String>? makeBefore,
    Expression<bool>? isCompleted,
    Expression<DateTime>? updateTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (textNote != null) 'text_note': textNote,
      if (importance != null) 'importance': importance,
      if (makeBefore != null) 'make_before': makeBefore,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (updateTime != null) 'update_time': updateTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({
    Value<String>? id,
    Value<String>? textNote,
    Value<String>? importance,
    Value<String?>? makeBefore,
    Value<bool>? isCompleted,
    Value<DateTime>? updateTime,
    Value<int>? rowid,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      textNote: textNote ?? this.textNote,
      importance: importance ?? this.importance,
      makeBefore: makeBefore ?? this.makeBefore,
      isCompleted: isCompleted ?? this.isCompleted,
      updateTime: updateTime ?? this.updateTime,
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
    if (updateTime.present) {
      map['update_time'] = Variable<DateTime>(updateTime.value);
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
          ..write('updateTime: $updateTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DatabaseVersionsTable extends DatabaseVersions
    with TableInfo<$DatabaseVersionsTable, DatabaseVersion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DatabaseVersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<DateTime> version = GeneratedColumn<DateTime>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, version];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'database_versions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DatabaseVersion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DatabaseVersion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DatabaseVersion(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      version:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}version'],
          )!,
    );
  }

  @override
  $DatabaseVersionsTable createAlias(String alias) {
    return $DatabaseVersionsTable(attachedDatabase, alias);
  }
}

class DatabaseVersion extends DataClass implements Insertable<DatabaseVersion> {
  final int id;
  final DateTime version;
  const DatabaseVersion({required this.id, required this.version});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['version'] = Variable<DateTime>(version);
    return map;
  }

  DatabaseVersionsCompanion toCompanion(bool nullToAbsent) {
    return DatabaseVersionsCompanion(id: Value(id), version: Value(version));
  }

  factory DatabaseVersion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DatabaseVersion(
      id: serializer.fromJson<int>(json['id']),
      version: serializer.fromJson<DateTime>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'version': serializer.toJson<DateTime>(version),
    };
  }

  DatabaseVersion copyWith({int? id, DateTime? version}) =>
      DatabaseVersion(id: id ?? this.id, version: version ?? this.version);
  DatabaseVersion copyWithCompanion(DatabaseVersionsCompanion data) {
    return DatabaseVersion(
      id: data.id.present ? data.id.value : this.id,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseVersion(')
          ..write('id: $id, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, version);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DatabaseVersion &&
          other.id == this.id &&
          other.version == this.version);
}

class DatabaseVersionsCompanion extends UpdateCompanion<DatabaseVersion> {
  final Value<int> id;
  final Value<DateTime> version;
  const DatabaseVersionsCompanion({
    this.id = const Value.absent(),
    this.version = const Value.absent(),
  });
  DatabaseVersionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime version,
  }) : version = Value(version);
  static Insertable<DatabaseVersion> custom({
    Expression<int>? id,
    Expression<DateTime>? version,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (version != null) 'version': version,
    });
  }

  DatabaseVersionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? version,
  }) {
    return DatabaseVersionsCompanion(
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (version.present) {
      map['version'] = Variable<DateTime>(version.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DatabaseVersionsCompanion(')
          ..write('id: $id, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }
}

abstract class _$NoteLocalService extends GeneratedDatabase {
  _$NoteLocalService(QueryExecutor e) : super(e);
  $NoteLocalServiceManager get managers => $NoteLocalServiceManager(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $DatabaseVersionsTable databaseVersions = $DatabaseVersionsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notes, databaseVersions];
}

typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      required String id,
      required String textNote,
      required String importance,
      Value<String?> makeBefore,
      Value<bool> isCompleted,
      required DateTime updateTime,
      Value<int> rowid,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<String> id,
      Value<String> textNote,
      Value<String> importance,
      Value<String?> makeBefore,
      Value<bool> isCompleted,
      Value<DateTime> updateTime,
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

  ColumnFilters<DateTime> get updateTime => $composableBuilder(
    column: $table.updateTime,
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

  ColumnOrderings<DateTime> get updateTime => $composableBuilder(
    column: $table.updateTime,
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

  GeneratedColumn<DateTime> get updateTime => $composableBuilder(
    column: $table.updateTime,
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
                Value<DateTime> updateTime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                textNote: textNote,
                importance: importance,
                makeBefore: makeBefore,
                isCompleted: isCompleted,
                updateTime: updateTime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String textNote,
                required String importance,
                Value<String?> makeBefore = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                required DateTime updateTime,
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion.insert(
                id: id,
                textNote: textNote,
                importance: importance,
                makeBefore: makeBefore,
                isCompleted: isCompleted,
                updateTime: updateTime,
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
typedef $$DatabaseVersionsTableCreateCompanionBuilder =
    DatabaseVersionsCompanion Function({
      Value<int> id,
      required DateTime version,
    });
typedef $$DatabaseVersionsTableUpdateCompanionBuilder =
    DatabaseVersionsCompanion Function({
      Value<int> id,
      Value<DateTime> version,
    });

class $$DatabaseVersionsTableFilterComposer
    extends Composer<_$NoteLocalService, $DatabaseVersionsTable> {
  $$DatabaseVersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DatabaseVersionsTableOrderingComposer
    extends Composer<_$NoteLocalService, $DatabaseVersionsTable> {
  $$DatabaseVersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DatabaseVersionsTableAnnotationComposer
    extends Composer<_$NoteLocalService, $DatabaseVersionsTable> {
  $$DatabaseVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);
}

class $$DatabaseVersionsTableTableManager
    extends
        RootTableManager<
          _$NoteLocalService,
          $DatabaseVersionsTable,
          DatabaseVersion,
          $$DatabaseVersionsTableFilterComposer,
          $$DatabaseVersionsTableOrderingComposer,
          $$DatabaseVersionsTableAnnotationComposer,
          $$DatabaseVersionsTableCreateCompanionBuilder,
          $$DatabaseVersionsTableUpdateCompanionBuilder,
          (
            DatabaseVersion,
            BaseReferences<
              _$NoteLocalService,
              $DatabaseVersionsTable,
              DatabaseVersion
            >,
          ),
          DatabaseVersion,
          PrefetchHooks Function()
        > {
  $$DatabaseVersionsTableTableManager(
    _$NoteLocalService db,
    $DatabaseVersionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$DatabaseVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DatabaseVersionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DatabaseVersionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> version = const Value.absent(),
              }) => DatabaseVersionsCompanion(id: id, version: version),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime version,
              }) => DatabaseVersionsCompanion.insert(id: id, version: version),
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

typedef $$DatabaseVersionsTableProcessedTableManager =
    ProcessedTableManager<
      _$NoteLocalService,
      $DatabaseVersionsTable,
      DatabaseVersion,
      $$DatabaseVersionsTableFilterComposer,
      $$DatabaseVersionsTableOrderingComposer,
      $$DatabaseVersionsTableAnnotationComposer,
      $$DatabaseVersionsTableCreateCompanionBuilder,
      $$DatabaseVersionsTableUpdateCompanionBuilder,
      (
        DatabaseVersion,
        BaseReferences<
          _$NoteLocalService,
          $DatabaseVersionsTable,
          DatabaseVersion
        >,
      ),
      DatabaseVersion,
      PrefetchHooks Function()
    >;

class $NoteLocalServiceManager {
  final _$NoteLocalService _db;
  $NoteLocalServiceManager(this._db);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$DatabaseVersionsTableTableManager get databaseVersions =>
      $$DatabaseVersionsTableTableManager(_db, _db.databaseVersions);
}
