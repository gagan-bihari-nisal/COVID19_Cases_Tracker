import 'dart:convert';

import 'package:http/http.dart'as http;
// To parse this JSON data, do
//
//     final responses = responsesFromJson(jsonString);

import 'dart:convert';

List<Responses> responsesFromJson(String str) => List<Responses>.from(json.decode(str).map((x) => Responses.fromJson(x)));

String responsesToJson(List<Responses> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


// Future<Responses> fetchit() async {
//   final response = await http
//       .get(Uri.parse('https://covid-19.dataflowkit.com/v1'));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Responses.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load');
//   }
// }
class Repository {
  static Future<List<Responses>> getIt() async {
    final response = await http.get(Uri.parse("https://covid-19.dataflowkit.com/v1"));
    return responsesFromJson(response.body);
  }
}




class Responses {
  Responses({
    this.activeCasesText,
    this.countryText,
    this.lastUpdate,
    this.newCasesText,
    this.newDeathsText,
    this.totalCasesText,
    this.totalDeathsText,
    this.totalRecoveredText,
  });

  String? activeCasesText;
  String? countryText;
  LastUpdate? lastUpdate;
  final newCasesText;
  final newDeathsText;
  final totalCasesText;
  final totalDeathsText;
  final totalRecoveredText;

  factory Responses.fromJson(Map<String, dynamic> json) => Responses(
    activeCasesText: json["Active Cases_text"] == null ? null : json["Active Cases_text"],
    countryText: json["Country_text"] == null ? null : json["Country_text"],
    lastUpdate: json["Last Update"] == null ? null : lastUpdateValues.map[json["Last Update"]],
    newCasesText: json["New Cases_text"] == null ? null : json["New Cases_text"],
    newDeathsText: json["New Deaths_text"] == null ? null : json["New Deaths_text"],
    totalCasesText: json["Total Cases_text"] == null ? null : json["Total Cases_text"],
    totalDeathsText: json["Total Deaths_text"] == null ? null : json["Total Deaths_text"],
    totalRecoveredText: json["Total Recovered_text"] == null ? null : json["Total Recovered_text"],
  );

  Map<String, dynamic> toJson() => {
    "Active Cases_text": activeCasesText == null ? null : activeCasesText,
    "Country_text": countryText == null ? null : countryText,
    "Last Update": lastUpdate == null ? null : lastUpdateValues.reverse![lastUpdate],
    "New Cases_text": newCasesText == null ? null : newCasesText,
    "New Deaths_text": newDeathsText == null ? null : newDeathsText,
    "Total Cases_text": totalCasesText == null ? null : totalCasesText,
    "Total Deaths_text": totalDeathsText == null ? null : totalDeathsText,
    "Total Recovered_text": totalRecoveredText == null ? null : totalRecoveredText,
  };
}

enum LastUpdate { THE_202111021707, THE_202111021607, THE_202111021107, THE_202111021507, THE_202111021207, THE_202111021407, THE_202111021307, THE_202111020906 }

final lastUpdateValues = EnumValues({
  "2021-11-02 09:06": LastUpdate.THE_202111020906,
  "2021-11-02 11:07": LastUpdate.THE_202111021107,
  "2021-11-02 12:07": LastUpdate.THE_202111021207,
  "2021-11-02 13:07": LastUpdate.THE_202111021307,
  "2021-11-02 14:07": LastUpdate.THE_202111021407,
  "2021-11-02 15:07": LastUpdate.THE_202111021507,
  "2021-11-02 16:07": LastUpdate.THE_202111021607,
  "2021-11-02 17:07": LastUpdate.THE_202111021707
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
