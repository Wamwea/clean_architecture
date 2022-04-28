import 'package:card_swiper/card_swiper.dart';
import 'package:clean_architecture/presentation/provider/news_provider.dart';
import 'package:clean_architecture/presentation/provider/togglers_provider.dart';
import 'package:clean_architecture/presentation/styling/styles.dart';
import 'package:clean_architecture/presentation/styling/theme_provider.dart';
import 'package:clean_architecture/presentation/widgets/featured_news_card.dart';
import 'package:clean_architecture/presentation/widgets/news_card.dart';
import 'package:clean_architecture/presentation/widgets/scaffold_widget.dart';
import 'package:clean_architecture/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(darkModeProvider.notifier).toggleDarkMode();
      },
      child: NotificationListener<UserScrollNotification>(
        onNotification: ((notification) {
          if (notification.direction == ScrollDirection.reverse) {
            ref.watch(toggleProvider.notifier).setFalse();
          } else if (notification.direction == ScrollDirection.forward) {
            ref.watch(toggleProvider.notifier).setTrue();
          }
          return true;
        }),
        child: NiuzzScaffold(
          appBar: ref.watch(toggleProvider)
              ? AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: ref.watch(darkModeProvider)
                      ? Colors.black
                      : const Color.fromARGB(255, 71, 59, 59),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {},
                          child: NiuzzText(
                            'NIUZZ APP',
                            style: logoTextStyle,
                          ),
                        ),
                      ]),
                )
              : null,
          showBottomBar: ref.watch(toggleProvider),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: ListView(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                      height: 230.h,
                      child: Center(
                        child: ref.watch(featuredNewsProvider).when(
                              data: (data) {
                                return data.fold(
                                    (l) => GestureDetector(
                                          onTap: () =>
                                              ref.refresh(featuredNewsProvider),
                                          child: NiuzzText(
                                            'Failed to get news , ${l.message}',
                                            style: labelTextStyle,
                                          ),
                                        ),
                                    (r) => Swiper(
                                        itemCount: r.length,
                                        scale: 0.9,
                                        duration: 1000,
                                        autoplay: true,
                                        autoplayDelay: 10000,
                                        itemBuilder: (context, index) =>
                                            FeaturedNewsCard(r[index])));
                              },
                              error: (data, err) =>
                                  NiuzzText('Error loading fies $err'),
                              loading: () => const SpinKitCubeGrid(
                                color: Colors.pink,
                              ),
                            ),
                      )),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.w),
                    child: GestureDetector(
                      onTap: () {
                        ref.refresh(featuredNewsProvider);
                        ref.refresh(newsProvider);
                        showTopSnackBar(
                            context,
                            const CustomSnackBar.info(
                                message: 'restarting search'));
                      },
                      child: NiuzzText(
                        'For you',
                        style: labelTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: ref.watch(newsProvider).when(
                          data: (data) => data.fold(
                              (l) => GestureDetector(
                                  onTap: () => ref.refresh(newsProvider),
                                  child: NiuzzText('whoops, ${l.message}')),
                              (r) => Column(
                                    children:
                                        r.map((e) => NewsComponent(e)).toList(),
                                  )),
                          error: (data, err) => Flexible(
                              child: GestureDetector(
                                  onTap: () => ref.refresh(newsProvider),
                                  child:
                                      NiuzzText('Error loading file, $err'))),
                          loading: () => Padding(
                            padding: EdgeInsets.only(top: 100.h),
                            child: const SpinKitCubeGrid(
                              color: Colors.pink,
                            ),
                          ),
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
