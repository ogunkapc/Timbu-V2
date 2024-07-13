import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/model/product_provider.dart';
import 'package:timbu_v2/screens/mainscreen/main_screen.dart';
import 'package:timbu_v2/service/api_service.dart';

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
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}
