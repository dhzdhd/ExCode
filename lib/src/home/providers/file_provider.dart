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
final activeFileProvider =
    StateNotifierProvider<_ActiveFileNotifier, Option<FileModel>>(
        (ref) => _ActiveFileNotifier());

class _ActiveFileNotifier extends StateNotifier<Option<FileModel>> {
  _ActiveFileNotifier() : super(const None());

  void set({required Option<FileModel> file}) {
    state = file;
  }
}

class _FilesNotifier extends StateNotifier<List<FileModel>> {
  _FilesNotifier() : super(_getExistingFiles());

  static List<FileModel> _getExistingFiles() {
    late final List<FileSystemEntity> files =
        appDocumentsDirectory.match(() => [], (r) => r.listSync().toList());

    return files.map((file) {
      final lang = langMap.values
          .firstWhere((element) => element.ext == extension(file.path, 2));
      final name = basename(file.path).split('.')[0];
      final ext = extension(file.path, 2);
      final content =
          FileService.readFileSync(name: name, ext: extension(file.path, 2))
              .match(
        (l) => lang.template,
        (r) => r,
      );
      return FileModel(
        name: name,
        content: content,
        language: lang.name,
        ext: ext,
      );
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

  TaskEither<FileError, String> save(FileModel file) {
    var newState = state;

    final res = FileService.saveFile(file);
    return res.map((r) {
      state = newState.filter((t) => t.name != file.name).append(file).toList();

      return r.path;
    });
  }
}
