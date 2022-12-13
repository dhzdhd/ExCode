import 'package:excode/src/factory.dart';
import 'package:excode/src/settings/models/settings_model.dart';

class CloudDatabase {
  static Future<void> save(SettingsModel settings) async {
    await supabase.from('settings').upsert(settings.toJson()).execute();
  }
}
