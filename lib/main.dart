import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vexana_example/models/weather_model.dart';
import 'package:vexana_example/services/weather_service/weather_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  runApp(MaterialApp(
    home: App(),
  ));
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String city = "Çanakkale";

  final WeatherService weatherService = WeatherService();

  final Duration debounce = const Duration(seconds: 1);

  Timer? debounceTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(city),
          actions: [
            IconButton(
              icon: const Icon(Icons.replay_outlined),
              onPressed: () => setState(() {}),
            ),
          ],
        ),
        body: Column(
          children: [
            TextField(
              onChanged: (term) {
                if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
                debounceTimer = Timer(debounce, () {
                  setState(() {
                    city = term;
                  });
                });
                ;
              },
            ),
            FutureBuilder<WeatherModel>(
              future: weatherService.getWeather(city),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text(snapshot.data?.cityName ?? "")),
                          Center(
                              child:
                                  Text(snapshot.data?.mainDescription ?? "")),
                          Center(
                              child:
                                  Text("Max: ${snapshot.data?.tempMax ?? ""}")),
                          Center(
                              child:
                                  Text("Min: ${snapshot.data?.tempMin ?? ""}")),
                          Center(
                              child: Text(
                                  "Pressure: ${snapshot.data?.pressure ?? ""}")),
                        ]);
                  } else {
                    return const Center(
                      child: Text("Bir sorun oluştu"),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ));
  }
}
