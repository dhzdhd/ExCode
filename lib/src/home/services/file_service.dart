import 'dart:io';

import 'package:excode/src/factory.dart';
import 'package:excode/src/helpers.dart';
import 'package:fpdart/fpdart.dart';

class FileError extends AppError {
  FileError(String message) : super(message);
}

class FileService {
  static TaskEither<FileError, File> createOrUpdateFile(
      String name, String content) {
    return TaskEither.fromOption(
      appDocumentsDirectory,
      () => FileError('File storage not supported on this platform'),
    ).flatMap((r) {
      print('${r.path}/$name.txt');
      final file = File('${r.path}/$name.txt');

      return TaskEither.tryCatch(
        () => file.writeAsString(content),
        (error, stackTrace) => FileError('Failed to update file'),
      );
    });
  }

  static TaskEither<FileError, String> readFile(String name) {
    return TaskEither.fromOption(
      appDocumentsDirectory,
      () => FileError('File storage not supported on this platform'),
    ).flatMap((r) {
      final file = File('${r.path}/$name.txt');

      return TaskEither.tryCatch(
        () => file.readAsString(),
        (error, stackTrace) => FileError('Failed to read file'),
      );
    });
  }

  static TaskEither<FileError, FileSystemEntity> deleteFile(String name) {
    return TaskEither.fromOption(
      appDocumentsDirectory,
      () => FileError('File storage not supported on this platform'),
    ).flatMap((r) {
      final file = File('${r.path}/$name.txt');

      return TaskEither.tryCatch(
        () => file.delete(),
        (error, stackTrace) => FileError('Failed to delete file'),
      );
    });
  }
}
