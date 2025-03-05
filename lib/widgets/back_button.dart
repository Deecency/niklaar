import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_rob/widgets/tappable.dart';

import '../core/core.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.isClose = false,
    this.onTap,
    this.bgColor,
    this.height,
    this.width,
    this.size,
    this.buttonColor,
  });
  final dynamic isClose;

  final VoidCallback? onTap;
  final Color? bgColor;
  final double? height;
  final double? width;
  final double? size;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap:
          onTap ??
          () async {
            await SystemChannels.textInput.invokeMethod('TextInput.hide');
            if (context.mounted) {
              context.pop();
            }
          },
      child:
          isClose
              ? Icon(
                CupertinoIcons.clear_circled,
                size: height ?? 24,
                color: buttonColor ?? AppColors.black,
              )
              : SvgPicture.asset(
                'assets/icons/ep_back.svg',
                height: height ?? 24,
                color: buttonColor ?? AppColors.black,
              ),
    );
  }
}
