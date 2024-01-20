import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/app.dart';
import 'package:movie_app/utils/storage_utils.dart';
import 'package:movie_app/view/module/popular/data/model/movie_response.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(MovieResponseAdapter());
  Hive.registerAdapter(MovieDetailsAdapter());
  StorageUtils.initHive();
  runApp(const App());
}
