import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

// flutter pub run build_runner (build/watch)

class Code extends Table {
  TextColumn get content => text()();
}

@DriftDatabase(tables: [Code])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> upsertCode(String content) {
    return into(code)
        .insertOnConflictUpdate(CodeCompanion(content: Value(content)));
  }

  Future<List<CodeData>> getCode() {
    return select(code).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
