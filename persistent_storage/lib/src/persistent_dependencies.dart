part of '../persistent_storage.dart';

class PersistentDependencies {
  static Future dependeincies() async {
    final prefs = await SharedPreferences.getInstance();
    Dependencies().registerSingleton<SharedPreferences>(prefs);
    Dependencies().registerFactory<SharedPreferencesStorage>(
      () => SharedPreferencesStorage(
        sharedPreferences: Dependencies().getIt(),
      ),
    );
  }
}
