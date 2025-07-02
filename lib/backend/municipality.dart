import 'dart:convert';
import 'package:http/http.dart' as http;

class MunicipalityInfo {
  final int id;
  final String name;
  final String imagePath;

  MunicipalityInfo({required this.id, required this.name, required this.imagePath});

  factory MunicipalityInfo.fromJson(Map<String, dynamic> json) {
    return MunicipalityInfo(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
    );
  }
}

Future<List<MunicipalityInfo>> fetchMunicipalities() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/municipalities/'));

  if (response.statusCode == 200) {
    final List jsonData = jsonDecode(response.body);
    return jsonData.map((item) => MunicipalityInfo.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load municipalities');
  }
}
