import 'dart:convert';

import 'package:first_app/models/annoucement_key_moment.dart';
import 'package:first_app/models/announcement.dart';
import 'package:first_app/models/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TrendingNewsProvider extends ChangeNotifier {
  List<Announcement> _trend = [];

  List<Announcement> get trend => _trend;

  Future<List<Announcement>> fetchTrend() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(trendingUrl), headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData =
          json.decode(response.body)['announcements'];
      final List<dynamic> data = jsonData['data'];
      _trend = data.map((e) => Announcement.fromJson(e)).toList();

      notifyListeners();
      return _trend;
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized!');
    } else {
      throw Exception('Failed to fetch noticeboard!');
    }
  }

  Future<Announcement> fetchTrendDetails(int trend_id) async {
    String token = await getToken();
    final response = await http
        .get(Uri.parse(announcementDetailUrl + '/${trend_id}'), headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      return Announcement.fromJson(jsonDecode(response.body)['data']);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized!');
    } else {
      throw Exception('Failed to fetch noticeboard!');
    }
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? '';
  }
}
