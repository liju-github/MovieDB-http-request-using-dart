import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchInceptionData() async {
  final url = Uri.parse('https://moviedatabase8.p.rapidapi.com/Search/Incep');
  final response = await http.get(url, headers: {
    'X-Rapidapi-Key': 'ae58b9922emsh40a11865abfacc2p1225c7jsn5f114fadab65', // expiring the apikey later :)
    'X-Rapidapi-Host': 'moviedatabase8.p.rapidapi.com',
  });

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}

Future<void> saveToJsonFile(List<dynamic> data) async {
  final file = File('inception_data.json');
  // Convert the data to a JSON string
  String jsonString = json.encode(data);
  // Write the JSON string to the file
  await file.writeAsString(jsonString);
  print('Data saved to inception_data.json');
}

void main() async {
  try {
    final data = await fetchInceptionData();
    await saveToJsonFile(data);
  } catch (e) {
    print(e);
  }
}
