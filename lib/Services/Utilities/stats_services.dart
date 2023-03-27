import 'dart:convert';
import 'package:covid_nineteen/Model/WorldStatsModel.dart';
import 'package:covid_nineteen/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<WorldStatsModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldstatsApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countrylist() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countrylist));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
