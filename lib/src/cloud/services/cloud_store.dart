import 'package:excode/src/cloud/models/cloud_model.dart';
import 'package:excode/src/cloud/services/supabase_db.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/snippet_model.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/settings/models/settings_model.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> saveToCloud({
  required Option<SettingsModel> settings,
  required Option<List<SnippetModel>> snippets,
  required Ref ref,
}) async {
  await CloudDatabase.upsert(
    CloudModel(
      settings: settings.match(
        (t) => t,
        () => ref.watch(settingsProvider),
      ),
      snippets: snippets.match(
        (t) => t,
        () => ref.watch(snippetBarStateProvider),
      ),
    ),
    supabase.auth.currentUser!.email!,
  );
}
