import 'dart:io';

import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/file_model.dart';
import 'package:excode/src/home/services/file_service.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';

final filesProvider = StateNotifierProvider<_FilesNotifier, List<FileModel>>(
    (ref) => _FilesNotifier());

class _FilesNotifier extends StateNotifier<List<FileModel>> {
  _FilesNotifier() : super(_getExistingFiles());

  static List<FileModel> _getExistingFiles() {
    late final List<FileSystemEntity> files =
        appDocumentsDirectory.match((r) => r.listSync().toList(), () => []);

    return files.map((file) {
      final lang = langMap.values
          .firstWhere((element) => element.ext == extension(file.path, 2));
      return FileModel(
          name: basename(file.path).split('.')[0],
          content: lang.template,
          language: lang.name,
          ext: extension(file.path, 2));
    }).toList();
  }

  TaskEither<FileError, String> add(FileModel file) {
    final newState = state;

    if (newState.any((element) => element.name == file.name)) {
      return TaskEither.left(
          FileError('File with the same name already exists!'));
    }

    final res = FileService.createOrUpdateFile(file);
    return res.map((r) {
      newState.add(file);
      state = newState;

      return r.path;
    });
  }

  TaskEither<FileError, String> remove(FileModel file) {
    var newState = state;

    final res = FileService.deleteFile(file);
    return res.map((r) {
      newState =
          newState.where((element) => element.name != file.name).toList();
      state = newState;

      return r.path;
    });
  }

  TaskEither<FileError, String> rename(FileModel file, String name) {
    var newState = state;

    final res = FileService.renameFile(file, name);
    return res.map((r) {
      final oldFile =
          newState.singleWhere((element) => element.name == file.name);
      state = newState
          .filter((t) => t.name != file.name)
          .append(FileModel(
            name: name,
            content: oldFile.content,
            language: oldFile.language,
            ext: oldFile.ext,
          ))
          .toList();

      return r.path;
    });
  }
}
