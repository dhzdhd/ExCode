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
      final ext = extension(file.path, 2);
      final lang = getLangFromExt(ext);
      final name = basename(file.path).split('.')[0];
      final content =
          FileService.readFileSync(path: Uri.file(file.absolute.path)).match(
        (l) => lang.template,
        (r) => r,
      );
      final path = Uri.file(file.absolute.path);
      return FileModel(
        name: name,
        content: content,
        language: lang.name,
        ext: ext,
        path: path,
      );
    }).toList();
  }

  TaskEither<FileError, String> create({
    required String name,
    required String language,
  }) {
    final newState = state;

    if (newState.any((element) => element.name == name)) {
      return TaskEither.left(
          FileError('File with the same name already exists!'));
    }

    final langModel = getLangFromName(language);
    final ext = langModel.ext;
    final pathStr =
        '${appDocumentsDirectory.toNullable()!.absolute.path}/$name$ext';
    final file = FileModel(
      name: name,
      content: langModel.template,
      language: language,
      ext: ext,
      path: Uri.file(pathStr),
    );
    final res = FileService.createOrUpdateFile(file);

    return res.map((r) {
      newState.add(file);
      state = newState;

      return r.path;
    });
  }

  Either<FileError, String> addOne({
    required FileModel file,
  }) {
    final newState = state;

    if (newState.any((element) => element.name == file.name)) {
      return Either.left(FileError('File with the same name already exists!'));
    }

    newState.add(file);
    state = newState;
    return Either.right('Success');
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
            path: Uri.file(
              oldFile.path.toString().replaceFirst(oldFile.name, name),
            ),
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
