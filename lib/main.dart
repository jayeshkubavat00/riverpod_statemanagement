import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statemanagement/modules/movie_trailler/screens/movies_trailler_screen.dart';
import 'package:riverpod_statemanagement/services/api_services_impl.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
  ApiServiceImpl().initializeApiServices();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
       
      ),
      home: const MoviesTraillerScreen(),
    );
  }
}
