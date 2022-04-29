import 'package:clean_architecture/presentation/styling/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_bar.dart';

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
