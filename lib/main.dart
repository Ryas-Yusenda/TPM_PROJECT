import 'package:flutter/material.dart';
import 'package:news_info/screen/home.dart';
import 'package:news_info/constants.dart';
import 'package:news_info/screen/onbording_screnn.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHomePage = prefs.getBool('showHomePage') ?? false;

  runApp(MyApp(showHomePage: showHomePage));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.showHomePage}) : super(key: key);

  final bool showHomePage;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Info',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          appBarTheme: const AppBarTheme(
            color: kThirdColor,
          )),
      home: showHomePage ? const HomePage() : const OnBordingScreen(),
    );
  }
}
