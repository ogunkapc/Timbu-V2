import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu/model/product_provider.dart';
import 'package:timbu/screens/splash_screen.dart';
import 'package:timbu/service/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(api: TimbuApi()),
      child: MaterialApp(
        title: 'Timbu',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
