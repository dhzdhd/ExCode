import 'dart:io';

import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/file_model.dart';
import 'package:fpdart/fpdart.dart';

class FileError implements Error {
  FileError(this._message);

  final String _message;
  String get message => _message;

  @override
  StackTrace? get stackTrace => StackTrace.fromString(_message);
}

class FileService {
  static TaskEither<FileError, File> createOrUpdateFile(FileModel file) {
    final file_ = File.fromUri(file.path);

    return TaskEither.tryCatch(
      () => file_.writeAsString(file.content),
      (error, stackTrace) {
        return FileError('Failed to update file');
      },
    );
  }

  static TaskEither<FileError, String> readFile({
    required String name,
    required String ext,
  }) {
    return TaskEither.fromOption(
      appDocumentsDirectory,
      () => FileError('File storage not supported on this platform'),
    ).flatMap((r) {
      final file_ = File('${r.path}/$name$ext');

      return TaskEither.tryCatch(
        () => file_.readAsString(),
        (error, stackTrace) => FileError('Failed to read file'),
      );
    });
  }

  static Either<FileError, String> readFileSync({required Uri path}) {
    return Either.fromOption(
      appDocumentsDirectory,
      () => FileError('File storage not supported on this platform'),
    ).flatMap((r) {
      final file_ = File.fromUri(path);

      return Either.tryCatch(
        () => file_.readAsStringSync(),
        (error, stackTrace) => FileError('Failed to read file'),
      );
    });
  }

  static TaskEither<FileError, File> saveFile(FileModel file) {
    return TaskEither.fromOption(
      appDocumentsDirectory,
      () => FileError('File storage not supported on this platform'),
    ).flatMap((r) {
      final file_ = File('${r.path}/${file.name}${file.ext}');

      return TaskEither.tryCatch(
        () => file_.writeAsString(file.content),
        (error, stackTrace) => FileError('Failed to write to file'),
      );
    });
  }

  static TaskEither<FileError, FileSystemEntity> deleteFile(FileModel file) {
    return TaskEither.fromOption(
      appDocumentsDirectory,
      () => FileError('File storage not supported on this platform'),
    ).flatMap((r) {
      final file_ = File('${r.path}/${file.name}${file.ext}');

      return TaskEither.tryCatch(
        () => file_.delete(),
        (error, stackTrace) => FileError('Failed to delete file'),
      );
    });
  }

  static TaskEither<FileError, File> renameFile(FileModel file, String name) {
    return TaskEither.fromOption(
      appDocumentsDirectory,
      () => FileError('File storage not supported on this platform'),
    ).flatMap((r) {
      final file_ = File('${r.path}/${file.name}${file.ext}');

      return TaskEither.tryCatch(
        () => file_.rename('${r.path}/$name${file.ext}'),
        (error, stackTrace) => FileError('Failed to rename file'),
      );
    });
  }
}
