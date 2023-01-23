import 'package:excode/src/home/models/file_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final filesProvider = StateNotifierProvider<_FilesNotifier, List<FileModel>>(
    (ref) => _FilesNotifier());

class _FilesNotifier extends StateNotifier<List<FileModel>> {
  _FilesNotifier()
      : super([
          const FileModel(
            name: 'main',
            content: '',
            language: 'python',
          ),
        ]);

  Either<String, String> addFile(FileModel file) {
    var newState = state;

    if (newState.any((element) => element.name == file.name)) {
      return const Left('File with the same name already exists!');
    }

    newState.add(file);
    state = newState;
    return const Right('Successfully created file');
  }

  void deleteFile(String name) {
    var newState = state;
    newState.where((element) => element.name != name);
    state = newState;
  }
}
