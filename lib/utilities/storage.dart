import 'package:shared_preferences/shared_preferences.dart';

abstract class Storage {
  Future<void> delete({String key});
  Future<String> read({String key});
  Future<void> write({String key, String value});
}

class PreferenceStorage extends Storage {
  final storage = SharedPreferences.getInstance();

  Future<void> delete({String key}) async => (await storage).remove(key);

  Future<String> read({String key}) async => (await storage).getString(key);
  Future<int> readInt({String key}) async => (await storage).getInt(key);
  Future<bool> readBool({String key}) async => (await storage).getBool(key);

  Future<void> write({String key, String value}) async =>
      (await storage).setString(key, value);
  Future<void> writeInt({String key, int value}) async =>
      (await storage).setInt(key, value);
  Future<void> writeBool({String key, bool value}) async =>
      (await storage).setBool(key, value);
}
