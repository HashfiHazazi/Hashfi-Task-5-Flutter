import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task5_application/src/modules/local_storage/login_local_storage.dart';
import 'package:task5_application/src/routers/route_names.dart';
import 'package:task5_application/src/routers/route_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getUserName = await LoginLocalStorage.getUserName();
  final getUserEmail = await LoginLocalStorage.getUserEmail();
  final getUserPhoneNumber = await LoginLocalStorage.getUserPhoneNumber();
  runApp(
    MyApp(
      userName: getUserName,
      userEmail: getUserEmail,
      userPhoneNumber: getUserPhoneNumber,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? userPhoneNumber;
  MyApp({super.key, this.userName, this.userEmail, this.userPhoneNumber});

  final route = RoutePages();

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
      initialRoute:
          (userName == null && userEmail == null && userPhoneNumber == null)
              ? RouteNames.login
              : RouteNames.article,
      debugShowCheckedModeBanner: false,
    );
  }
}
