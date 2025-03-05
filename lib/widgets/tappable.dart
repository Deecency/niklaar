import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprung/sprung.dart';

class Tappable extends StatefulWidget {
  const Tappable({
    super.key,
    this.behavior,
    this.type = TappableType.press,
    required this.child,
    this.onTap,
    this.onLongPress,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final HitTestBehavior? behavior;
  final TappableType type;

  @override
  State<Tappable> createState() => _TappableState();
}

class _TappableState extends State<Tappable> {
  var pressed = false;

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onTap == null;
    final opacity = disabled ? 0.4 : (pressed ? 0.1 : 1.0);

    return GestureDetector(
      behavior: widget.behavior ?? HitTestBehavior.translucent,
      onLongPress:
          widget.onLongPress == null
              ? null
              : () {
                widget.onLongPress?.call();
                HapticFeedback.mediumImpact();
              },
      onTap:
          widget.onTap == null
              ? null
              : () {
                widget.onTap?.call();
                HapticFeedback.lightImpact();
              },
      onTapDown: (_) {
        if (widget.onTap == null) return;
        setState(() => pressed = true);
      },
      onTapUp: (_) {
        setState(() => pressed = false);
      },
      onTapCancel: () {
        setState(() => pressed = false);
      },
      child: switch (widget.type) {
        TappableType.opacity => Opacity(opacity: opacity, child: widget.child),
        TappableType.press => AnimatedScale(
          duration: const Duration(milliseconds: 300),
          curve: Sprung.overDamped,
          scale: pressed ? 0.97 : 1.0,
          child: widget.child,
        ), // AnimatedScale

        TappableType.none => widget.child,
      },
    ); // GestureDetector
  }
}

enum TappableType { none, press, opacity }
