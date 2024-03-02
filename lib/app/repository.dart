import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pulse_bay_task/app/constants/environment.dart';
import 'package:pulse_bay_task/app/models/city.dart';
import 'package:pulse_bay_task/app/models/industry.dart';
import 'package:pulse_bay_task/app/models/trade.dart';
import 'package:http/http.dart' as http;

class AppRepository {
  static Future _get(String url) async {
    try {
      var request = http.Request('GET', Uri.parse('${ENV.baseUrl}$url'));
      // EasyLoading.show();
      http.StreamedResponse response = await request.send();
      // EasyLoading.dismiss();
      try {
        var res = json.decode(await response.stream.bytesToString());
        return res;
      } catch (exception) {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }

  static Future _post({required String url, dynamic body}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse('${ENV.baseUrl}$url'));
      request.body = body;
      request.headers.addAll(headers);
      EasyLoading.show();
      http.StreamedResponse response = await request.send();
      EasyLoading.dismiss();
      try {
        var res = json.decode(await response.stream.bytesToString());
        return res;
      } catch (exception) {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }

  static Future<bool> login({
    required String email,
    required String passWord,
  }) async {
    var body = json.encode({
      "email": email,
      "password": passWord,
      "firebase_token": "sdsdasdfsdgsfvgedsrg3"
    });
    dynamic response = await _post(url: ENV.login, body: body);
    bool success = response['id'] != null;
    return success;
  }

  static Future<List<CitySchema>> fetchCity() async {
    List<CitySchema> cities = [];
    dynamic response = await _get(ENV.regions);
    if (response['data'] != null) {
      List parsedRes = response['data'];
      cities = parsedRes.map((e) => CitySchema.fromJson(e)).toList();
    }
    return cities;
  }

  static Future<List<IndustrySchema>> fetchIndustries({
    int offset = 0,
    int limit = 1000,
  }) async {
    List<IndustrySchema> industries = [];
    dynamic response = await _get(ENV.industries(
      offset: offset,
      limit: limit,
    ));
    if (response['data'] != null) {
      List parsedRes = response['data'];
      industries = parsedRes.map((e) => IndustrySchema.fromJson(e)).toList();
    }
    return industries;
  }

  static Future<List<TradeSchema>> fetchTraders({
    int id1 = 5,
    int id2 = 6,
  }) async {
    List<TradeSchema> traders = [];
    dynamic response = await _get(ENV.search(
      id1: id1,
      id2: id2,
    ));
    if (response['data'] != null) {
      List parsedRes = response['data'];
      traders = parsedRes.map((e) => TradeSchema.fromJson(e)).toList();
    }
    return traders;
  }
}
