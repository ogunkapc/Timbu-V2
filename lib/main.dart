import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timbu_v2/providers/cart_provider.dart';
import 'package:timbu_v2/providers/product_provider.dart';
import 'package:timbu_v2/screens/mainscreen/main_screen.dart';
import 'package:timbu_v2/service/api_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(api: TimbuApi()),
        ),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          title: 'Timbu',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: const MainScreen(),
    );
  }
}
