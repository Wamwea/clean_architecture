import 'package:clean_architecture/injector.dart' as di;
import 'package:clean_architecture/presentation/styling/theme_provider.dart';
import 'package:clean_architecture/presentation/views/home_page.dart';
import 'package:clean_architecture/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Hive.initFlutter();
  runApp(ProviderScope(
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (context) => const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
