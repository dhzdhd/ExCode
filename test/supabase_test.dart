import 'package:excode/src/cloud/models/cloud_model.dart';
import 'package:excode/src/cloud/services/supabase_db.dart';
import 'package:excode/src/factory.dart';
import 'package:test/test.dart';

void main() {
  setUp(() async {
    await initCloudStorage();
  });

  group('Supabase', () {
    test('Supabase data is properly serialised', () async {
      final response = await CloudDatabase.fetchAll();

      expect(response.isRight(), true);

      response.match(
        // ! Not being called for some reason
        (l) => null,
        (r) => r.map((e) {
          // print(e.toString());
          CloudModel.fromJson(e['data']);
        }),
      );
    });
  });
}
