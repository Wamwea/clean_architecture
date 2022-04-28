import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/domain/entities/news_object.dart';
import 'package:clean_architecture/injector.dart';
import 'package:clean_architecture/presentation/provider/news_provider.dart';
import 'package:clean_architecture/presentation/styling/styles.dart';
import 'package:clean_architecture/presentation/widgets/scaffold_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clean_architecture/presentation/widgets/text_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/repositories/local_repository.dart';

class FeaturedNewsCard extends ConsumerWidget {
  const FeaturedNewsCard(this.item, {Key? key}) : super(key: key);
  final NewsObject item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
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
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        child: Container(
          height: 250.h,
          color: Colors.grey.withOpacity(0.1),
          width: double.infinity,
          child: Column(children: [
            Expanded(
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      imageUrl: item.imageUrl == null
                          ? 'https://image.shutterstock.com/image-photo/cow-on-background-sky-green-600w-1728214024.jpg'
                          : item.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.cabin,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  NiuzzText(
                                    item.author,
                                    style: labelTextStyle,
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await locator<LocalRepository>()
                                      .saveNewsArticle(item);
                                  ref.refresh(savedNewsProvider);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r))),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 8.w),
                                    child:
                                        const Icon(Icons.bookmark_add_outlined),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                flex: 2),
            Padding(
              padding: EdgeInsets.only(top: 8.0.h, left: 5.w, bottom: 5.h),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NiuzzText(item.title.trim()),
                    NiuzzText(timeago.format(item.pubDate)),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
