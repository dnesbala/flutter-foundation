import 'package:first_app/config/app_routes.dart';
import 'package:first_app/form_validation_test.dart';
import 'package:first_app/navigation/home_page.dart';
import 'package:first_app/networking/user_screen.dart';
import 'package:first_app/screens/welcome_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/route_handler.dart';
import 'navigation/login_page.dart';
import 'navigation/profile_page.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  bool isDarkMode = false;
  bool hasToken = false;

  void _toggleTheme() {
    setStateIfMounted(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  void initState() {
    // SharedPreferences.getInstance().then((prefs) => prefs.clear());
    checkToken();
    super.initState();
  }

  checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token != null) {
      // hasToken = true;
    }
    //  else {
    //   hasToken = false;
    // }
    setStateIfMounted(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      debugShowCheckedModeBanner: false,
      // home:
      //     FormValidationTest(isDarkMode: isDarkMode, toggleTheme: _toggleTheme),
      // routes: {
      //   AppRoutes.index: (_) => LoginPage(),
      //   AppRoutes.home: (_) => HomePage(),
      //   AppRoutes.profile: (context) => ProfilePage(),
      // },
      // onGenerateRoute: generateRoute,
      home: hasToken ? WelcomeScreen() : UserScreen(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade200,
        // appBarTheme: AppBarTheme(
        //   color: Colors.green,
        //   elevation: 0,
        // ),
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          accentColor: Colors.amber,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 40),
          headline2: TextStyle(fontSize: 32),
          bodyText1: TextStyle(fontSize: 14, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
          ),
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
