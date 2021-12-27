import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'Weather',
    home: Weather(),
  ));
}

String api_key = '8dc1de472cca2bc6119af749d8a834f9';

Future<dynamic> fetchData() async {
  print('helloo');
  var result = await http.get(Uri.http(
      'api.openweathermap.org', 'data/2.5/weather', {
    'lat': '15.53804515',
    'lon': '32.52674103',
    'appid': api_key,
    'units': 'metric'
  }));
  var res = json.decode(result.body);
  // print(res);
  return res;
}

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Color bgcolor;
  var data;
  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      // print(value);
      setState(() {
        data = value;
        // print(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        appBar: AppBar(
          title: Text('Weather App'),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
        ),
        body: Center(
          child: data == null
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          data['main']['temp'].toString() + ' c',
                          style: TextStyle(
                              fontSize: 54,
                              color: Colors.white,
                              letterSpacing: 2),
                        ),
                        SizedBox(height: 40),
                        Text(data['name'],
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                letterSpacing: 2)),
                        SizedBox(height: 30),
                        Text(data['weather'][0]['description'],
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 2))
                      ]),
                ),
        ));
  }
}
