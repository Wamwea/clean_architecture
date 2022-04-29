import 'package:clean_architecture/presentation/styling/theme_provider.dart';
import 'package:clean_architecture/presentation/views/saved_news_page.dart';
import 'package:clean_architecture/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../views/home_page.dart';

class NiuzzScaffold extends ConsumerWidget {
  const NiuzzScaffold(
      {Key? key, required this.body, this.appBar, this.showBottomBar = true})
      : super(key: key);

  final Widget body;
  final AppBar? appBar;
  final bool showBottomBar;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor:
            ref.watch(darkModeProvider) ? Colors.black : Colors.white,
        body: Stack(
          children: [body, NiuzzBottomBar(showBottomBar: showBottomBar)],
        ),
      ),
    );
  }
}

class NiuzzBottomBar extends StatelessWidget {
  const NiuzzBottomBar({
    Key? key,
    required this.showBottomBar,
  }) : super(key: key);

  final bool showBottomBar;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: showBottomBar ? 1 : 0,
      child: Hero(
        tag: 'hero',
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40.h,
              clipBehavior: Clip.hardEdge,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.9),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.r),
                  )),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen())),
                        child: Center(
                            child: Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                          size: 30.r,
                        )),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SavedNewsPage())),
                        child: Center(
                            child: Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 30.r,
                        )),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NiuzzScaffold(
                                    body: Center(
                                      child: NiuzzText('PROFILE PAGE'),
                                    ),
                                    showBottomBar: true))),
                        child: Center(
                            child: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.white,
                          size: 30.r,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
