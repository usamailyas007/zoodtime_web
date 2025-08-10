import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class Configs{
  // static String baseUrl = "http://192.168.10.5.11:3000";
  static String baseUrl = "https://zood-nine.vercel.app";

  static final customCacheManager = CacheManager(
    Config(
      'sasImageCache',
      stalePeriod: const Duration(days: 1),
      maxNrOfCacheObjects: 20,
      repo: JsonCacheInfoRepository(databaseName: 'sasCache'),
      fileService: HttpFileService(
        httpClient: http.Client(),
      ),
    ),
  );

}