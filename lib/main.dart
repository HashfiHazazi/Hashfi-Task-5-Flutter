import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task5_application/src/routers/route_names.dart';
import 'package:task5_application/src/routers/route_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final route = RoutePages();
  MyApp({super.key});                                  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      title: 'Task 5 Application',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF247881),
          primary: const Color(0xFF247881),
          onPrimary: Colors.white,
          secondary: const Color(0xFF006778),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: route.onRoute,
      initialRoute: RouteNames.login,
      debugShowCheckedModeBanner: false,
    );
  }
}
