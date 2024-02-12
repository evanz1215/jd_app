import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jd_app/page/index_page.dart';
import 'package:jd_app/provider/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env.development");
  runApp(
    ChangeNotifierProvider.value(
      value: BottomNavProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.deepPurple,
      ),
      home: const IndexPage(),
    );
  }
}
