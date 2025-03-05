import 'package:flutter/material.dart';
import 'package:smart_rob/widgets/tappable.dart';

import '../core/core.dart';

enum ABStatus { enabled, disabled, loading }

enum ABStyle { primary, secondary }

enum ABShape { rounded }

enum ABSize { medium }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.onLongPress,
    this.status = ABStatus.enabled,
    this.style = ABStyle.primary,
    this.shape = ABShape.rounded,
    this.size = ABSize.medium,
    this.width,
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ABStatus status;
  final ABStyle style;
  final ABShape shape;
  final ABSize size;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: onTap,
      onLongPress: onLongPress,
      type: switch (status) {
        ABStatus.enabled => TappableType.press,
        ABStatus.disabled || ABStatus.loading => TappableType.opacity,
      },
      child: Container(
        width: width ?? (MediaQuery.sizeOf(context).width - 32),
        height: switch (size) {
          ABSize.medium => 51.relHeight,
        },
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: switch (style) {
            ABStyle.primary => AppColors.primary,

            ABStyle.secondary => Colors.white,
          },
          shape: switch (shape) {
            ABShape.rounded => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ), // RoundedRectangleBorder
          },
        ), // ShapeDecoration
        child: Text(
          text,
          style: switch (size) {
            ABSize.medium => TextStyles.w600_16(context).copyWith(
              color: switch (style) {
                ABStyle.primary => AppColors.white,

                ABStyle.secondary => AppColors.primary,
              },
            ),
          },
        ),
      ), // Container
    ); // Tappable
  }
}
