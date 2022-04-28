import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/domain/repositories/local_repository.dart';
import 'package:clean_architecture/injector.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:clean_architecture/presentation/styling/theme_provider.dart';
import 'package:clean_architecture/presentation/widgets/scaffold_widget.dart';
import 'package:clean_architecture/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:timeago/timeago.dart%20';
import 'package:webview_flutter/webview_flutter.dart';

class NewsComponent extends ConsumerWidget {
  const NewsComponent(this.item, {Key? key}) : super(key: key);
  final NewsObject item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Slidable(
        endActionPane: ActionPane(
            extentRatio: 0.75,
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  locator<LocalRepository>().saveNewsArticle(item).then(
                      (value) => showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                              message: 'Article saved to local storage')));
                },
                label: 'Save',
                backgroundColor: Colors.grey.shade600,
              ),
              SlidableAction(
                backgroundColor: Colors.grey.shade400,
                onPressed: (context) {},
                label: 'Open in browser',
              ),
            ]),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NiuzzScaffold(
                        showBottomBar: false,
                        body: SafeArea(
                          child: WebView(
                            initialUrl: item.link,
                          ),
                        ),
                      ))),
          child: Container(
            width: double.maxFinite,
            height: 75.h,
            decoration: BoxDecoration(
              color: ref.watch(darkModeProvider)
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(8.r),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 5.w,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  child: SizedBox(
                      height: 70.h,
                      width: 80.w,
                      child: CachedNetworkImage(
                        height: 70.h,
                        width: 70.w,
                        imageUrl: item.imageUrl == null
                            ? 'https://image.shutterstock.com/image-photo/cow-on-background-sky-green-600w-1728214024.jpg'
                            : item.imageUrl!,
                        fit: BoxFit.cover,
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 5.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        NiuzzText(item.title),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NiuzzText(item.author),
                            NiuzzText(format(item.pubDate))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
