// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:movie_app/view/module/popular/data/model/movie_response.dart';

// class StorageUtils {
//   StorageUtils._();

//   static final StorageUtils _instance = StorageUtils._();

//   static StorageUtils get instance => _instance;

//   static late Box box;

//   static const _movieData = 'movieData';

//   static Future<void> initHive() async {
//     box = await Hive.openBox<List<MovieDetails>>(_movieData);
//   }

//   //sets

//   static Future<void> setBool(String key, bool value) async => await box.put(key, value);

//   static Future<void> setDouble(String key, double value) async => await box.put(key, value);

//   static Future<void> setInt(String key, int value) async => await box.put(key, value);

//   static Future<void> setString(String key, String value) async => await box.put(key, value);

//   static Future<void> setStringList(String key, List<String> value) async => await box.put(key, value);

//   static void setMovieData(List<MovieDetails>? data) => box.put(_movieData, data);

//   //gets

//   static bool? getBool(String key) => box.get(key);

//   static double? getDouble(String key) => box.get(key);

//   static int? getInt(String key) => box.get(key);

//   static String? getString(String key) => box.get(key);

//   static List<String>? getStringList(String key) => box.get(key);

//   static List<MovieDetails>? getMovieData() {
//     debugPrint('uuuu :: ${box.get(_movieData)}');
//     return (box.get(_movieData) ?? <MovieDetails>[]) as List<MovieDetails>;
//   }

//   //deletes..
//   static Future<void> remove(String key) async => await box.delete(key);

//   static Future<void> clear() async => await box.clear();
// }
