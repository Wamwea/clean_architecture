import 'package:clean_architecture/presentation/styling/styles.dart';
import 'package:clean_architecture/presentation/styling/theme_provider.dart';
import 'package:clean_architecture/presentation/views/home_page.dart';
import 'package:clean_architecture/presentation/widgets/scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    initializeApp();
    super.initState();
  }

  void initializeApp() async {
    await ref.read(darkModeProvider.notifier).getTheme();
    await Future.delayed(Duration(seconds: 2));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('NIUZZ',
              style: normalTextStyle.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: 50,
                  color: Colors.white)),
          const SizedBox(
            height: 10,
          ),
          const SpinKitPianoWave(color: Colors.pinkAccent)
        ],
      ),
    );
  }
}
