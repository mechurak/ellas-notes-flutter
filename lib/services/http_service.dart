import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/app_config.dart';

class HttpService {
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? _base_url;

  HttpService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _base_url = _appConfig!.COIN_API_BASE_URL;
  }

  Future<Response?> get(String path) async {
    try {
      String url = "$_base_url$path";
      Response response = await dio.get(url);
      return response;

    } catch(e) {
      print("HttpService: Unable to perform get request.");
      print(e);
    }
  }
}
