import 'package:http/http.dart' as http;

class StartMonitoring {
  Future<void> startMonitoring() async {
    final url = Uri.parse('http://192.168.169.49:5000/startMonitoring');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('Sensor data collection started');
    } else {
      print('Error starting sensor data collection');
    }
  }
}
