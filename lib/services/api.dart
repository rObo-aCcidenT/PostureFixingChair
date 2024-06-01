import 'package:http/http.dart' as http;
Future<void> fetchData() async {
  final response = await http.get(Uri.parse('(http://192.168.169.49:5000/startMonitoring)'));
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Error: ${response.statusCode}');
  }
}