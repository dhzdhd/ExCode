// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CodeData extends DataClass implements Insertable<CodeData> {
  final String content;
  CodeData({required this.content});
  factory CodeData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CodeData(
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content'] = Variable<String>(content);
    return map;
  }

  CodeCompanion toCompanion(bool nullToAbsent) {
    return CodeCompanion(
      content: Value(content),
    );
  }

  factory CodeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CodeData(
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'content': serializer.toJson<String>(content),
    };
  }

  CodeData copyWith({String? content}) => CodeData(
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('CodeData(')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => content.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CodeData && other.content == this.content);
}

class CodeCompanion extends UpdateCompanion<CodeData> {
  final Value<String> content;
  const CodeCompanion({
    this.content = const Value.absent(),
  });
  CodeCompanion.insert({
    required String content,
  }) : content = Value(content);
  static Insertable<CodeData> custom({
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (content != null) 'content': content,
    });
  }

  CodeCompanion copyWith({Value<String>? content}) {
    return CodeCompanion(
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CodeCompanion(')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $CodeTable extends Code with TableInfo<$CodeTable, CodeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CodeTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [content];
  @override
  String get aliasedName => _alias ?? 'code';
  @override
  String get actualTableName => 'code';
  @override
  VerificationContext validateIntegrity(Insertable<CodeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  CodeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CodeData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CodeTable createAlias(String alias) {
    return $CodeTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CodeTable code = $CodeTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [code];
}
