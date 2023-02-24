import 'package:excode/src/home/models/file_model.dart';
import 'package:excode/src/home/services/file_service.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final filesProvider = StateNotifierProvider<_FilesNotifier, List<FileModel>>(
    (ref) => _FilesNotifier());

class _FilesNotifier extends StateNotifier<List<FileModel>> {
  _FilesNotifier()
      : super([
          FileModel(
              name: 'main',
              content: langMap['python']!.template,
              language: 'python',
              ext: '.py'),
        ]);

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
}
