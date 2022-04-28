import 'package:clean_architecture/presentation/styling/styles.dart';
import 'package:clean_architecture/presentation/styling/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NiuzzText extends ConsumerWidget {
  const NiuzzText(this.text, {Key? key, this.style, this.noOverflow})
      : super(key: key);
  final String text;
  final TextStyle? style;
  final bool? noOverflow;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      text,
      overflow: noOverflow == null ? null : TextOverflow.ellipsis,
      style: style != null
          ? style!.copyWith(
              color: ref.watch(darkModeProvider) ? Colors.white : Colors.black)
          : normalTextStyle.copyWith(
              color: ref.watch(darkModeProvider) ? Colors.white : Colors.black),
    );
  }
}
