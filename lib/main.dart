import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/screens/homepage.dart';
import 'package:news/screens/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(false)),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final newsProv = context.watch<NewsProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1E2D62),
          secondary: Color(0xFF1E2D62),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.black87,
          actionTextColor: Color(0xFF1E2D62),
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF1E2D62),
          unselectedItemColor: Colors.grey,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF1E2D62),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.amber,
          secondary: Colors.amber,
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.grey,
          actionTextColor: Colors.amber,
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.amber,
        ),
      ),
      themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: newsProv.isLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}
