import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // Make HTTP GET request to Flask server
              Uri url = Uri.parse('http://your-flask-server-ip:port/your-endpoint');
              http.Response response = await http.get(url);

              // Handle response
              if (response.statusCode == 200) {
                print('Response body: ${response.body}');
                // Handle successful response
              } else {
                print('Failed to fetch data: ${response.statusCode}');
                // Handle error
              }
            },
            child: Text('Send Request'),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
