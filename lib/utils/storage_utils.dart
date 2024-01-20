import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

class StorageUtils {
  StorageUtils._();

  static final StorageUtils _instance = StorageUtils._();

  static StorageUtils get instance => _instance;

  static late Box _box;

  static const _movieData = 'movieData';

  static Future<void> initHive() async {
    _box = await Hive.openBox('movieApp');
  }

  //sets

  static Future<void> setBool(String key, bool value) async => await _box.put(key, value);

  static Future<void> setDouble(String key, double value) async => await _box.put(key, value);

  static Future<void> setInt(String key, int value) async => await _box.put(key, value);

  static Future<void> setString(String key, String value) async => await _box.put(key, value);

  static Future<void> setStringList(String key, List<String> value) async => await _box.put(key, value);

  static void setMovieData(MovieDetails? data) => _box.put(_movieData, data);

  //gets

  static bool? getBool(String key) => _box.get(key);

  static double? getDouble(String key) => _box.get(key);

  static int? getInt(String key) => _box.get(key);

  static String? getString(String key) => _box.get(key);

  static List<String>? getStringList(String key) => _box.get(key);

  static MovieDetails? getMenuData() => _box.get(_movieData);
  //deletes..
  static Future<void> remove(String key) async => await _box.delete(key);

  static Future<void> clear() async => await _box.clear();
}
