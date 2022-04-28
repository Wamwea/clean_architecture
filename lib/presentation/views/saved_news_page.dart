import 'package:clean_architecture/presentation/provider/news_provider.dart';
import 'package:clean_architecture/presentation/styling/styles.dart';
import 'package:clean_architecture/presentation/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';

import '../widgets/scaffold_widget.dart';
import '../widgets/text_widget.dart';

class SavedNewsPage extends ConsumerWidget {
  const SavedNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NiuzzScaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0.w),
            child: GestureDetector(
              onTap: () => ref.refresh(savedNewsProvider),
              child: NiuzzText(
                'Saved News',
                style: labelTextStyle,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ref.watch(savedNewsProvider).when(
              data: (data) => Column(
                    children: data.map((e) => NewsComponent(e)).toList(),
                  ),
              error: (err, stacktrace) => NiuzzText(
                  ' Error getting saved articles [$err: ,${Hive.box('database').get('saved_news')}}], $stacktrace'),
              loading: () => const SpinKitChasingDots(
                    color: Colors.pink,
                  ))
        ],
      ),
    );
  }
}
