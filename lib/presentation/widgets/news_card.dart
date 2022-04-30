import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/domain/repositories/local_repository.dart';
import 'package:clean_architecture/injector.dart';
import 'package:clean_architecture/presentation/provider/news_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:clean_architecture/presentation/styling/theme_provider.dart';
import 'package:clean_architecture/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timeago/timeago.dart%20';
import 'package:url_launcher/url_launcher_string.dart';

class NewsComponent extends ConsumerWidget {
  const NewsComponent(this.item, {Key? key, this.isLocal}) : super(key: key);
  final NewsObject item;
  final bool? isLocal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool local = (isLocal != null && isLocal == true);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Slidable(
        endActionPane: ActionPane(
            extentRatio: local ? 0.5 : 0.3,
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  locator<LocalRepository>().saveNewsArticle(item).then(
                      (value) => showTopSnackBar(
                          context,
                          const CustomSnackBar.success(
                              message: 'Article saved to local storage'),
                          displayDuration: const Duration(seconds: 1),
                          showOutAnimationDuration: Duration.zero));
                },
                label: 'Save',
                backgroundColor: Colors.grey.shade600,
              ),
              local
                  ? SlidableAction(
                      onPressed: (context) {
                        locator<LocalRepository>()
                            .deleteSavedNews(item)
                            .then((value) {
                          showTopSnackBar(
                              context,
                              const CustomSnackBar.success(
                                  message:
                                      'Article deleted from local storage'),
                              displayDuration: const Duration(seconds: 1),
                              showOutAnimationDuration: Duration.zero);
                        });
                      },
                      label: 'Delete',
                      backgroundColor: Colors.red,
                    )
                  : const SizedBox.shrink()
            ]),
        child: GestureDetector(
          onTap: () => launchUrlString(item.link),
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
