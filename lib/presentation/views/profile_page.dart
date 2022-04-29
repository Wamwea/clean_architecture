import 'package:clean_architecture/presentation/styling/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styling/theme_provider.dart';
import '../widgets/scaffold_widget.dart';
import '../widgets/text_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NiuzzScaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                color:
                    ref.watch(darkModeProvider) ? Colors.blue : Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            height: 100.h,
            width: 150.w,
            child: GestureDetector(
                onTap: () =>
                    ref.read(darkModeProvider.notifier).toggleDarkMode(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NiuzzText(
                      'Change Theme: ${ref.watch(darkModeProvider) ? 'Dark' : 'Light'}',
                      style: labelTextStyle,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        child: ref.watch(darkModeProvider)
                            ? Icon(
                                Icons.nightlight,
                                size: 50.sm,
                              )
                            : Icon(
                                Icons.sunny,
                                size: 50.sm,
                              )),
                  ],
                )),
          ),
        ),
        showBottomBar: true);
  }
}
