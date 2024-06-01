
import 'package:http/http.dart' as http;
import 'dart:convert';

class SensorDataRepository {
  Future<List> retrieveSensorData() async {
    // final url = Uri.parse('http://127.0.0.1:5000/start_monitoring');
    final url = Uri.parse('http://192.168.169.49:5000/startMonitoring');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      print('Error retrieving sensor data');
      return [];
    }
  }

  void processSensorData(List sensorData) {
    // Process the retrieved sensor data here
  }
}