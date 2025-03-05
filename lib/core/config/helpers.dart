import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_rob/widgets/widgets.dart';

import '../core.dart';

///This mixin used for showing dialogs,overlay,bootomsheet,snackbars which automatically disposed
///when the stateful class use this class disposes.s
mixin GlobalHelper<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;
  AnimationController? _animationController;
  Completer<void> completer = Completer();

  void showLoadingOverlay({required BuildContext context}) {
    showCustomOverlay(
      context: context,
      builder:
          (context) => ColoredBox(
            color: AppColors.black.withValues(alpha: 0.2),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                trackGap: 4,
                backgroundColor: AppColors.white,
              ),
            ),
          ),
    );
  }

  void showCProgressOverlay({
    required BuildContext context,
    required TickerProvider vsync,
  }) {
    _animationController = AnimationController(vsync: vsync, value: 0);

    showCustomOverlay(
      context: context,
      builder:
          (context) => ColoredBox(
            color: Colors.black54,
            child: Center(
              child: AnimatedBuilder(
                animation: _animationController!.view,
                builder: (BuildContext context, Widget? child) {
                  return CircularProgressIndicator(
                    value: _animationController?.value,
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),
    );
  }

  set updateProgress(double value) {
    _animationController?.value = value;
  }

  Future<S?> showCustomDialog<S>({
    required BuildContext context,
    required WidgetBuilder builder,
    String? routerName,
    bool barrierDismissible = true,
  }) {
    return showDialog<S>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      routeSettings:
          routerName != null ? RouteSettings(name: routerName) : null,
      builder: (BuildContext buildContext) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return pageChild;
            },
          ),
        );
      },
    );
  }

  void showSuccessSnack(BuildContext context, {String? text}) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top + 20,
          left: 10,
          right: 10,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.checkmark_alt_circle,
                    size: 24,
                    color: AppColors.white,
                  ),
                  10.hSpace,
                  Expanded(
                    child: Text(
                      '$text',
                      style: AppFonts.w400.copyWith(color: Colors.white),
                    ),
                  ),
                  AppBackButton(
                    isClose: true,
                    buttonColor: Colors.white,
                    onTap: () {
                      overlayEntry.remove();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  Future<void> showErrorSnack(
    BuildContext context, {
    String? text,
    TextStyle? textStyle,
  }) async {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top + 20,
          left: 10,
          right: 10,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.clear_thick_circled,
                    size: 24,
                    color: AppColors.white,
                  ),
                  10.hSpace,
                  Expanded(
                    child: SizedBox(
                      width: 266,
                      child: Text(
                        '$text',
                        style:
                            textStyle ??
                            AppFonts.w500.copyWith(
                              color: Colors.white,
                              letterSpacing: -0.05,
                              fontSize: 14,
                              height: 24 / 14,
                            ),
                      ),
                    ),
                  ),
                  12.hSpace,
                  AppBackButton(
                    isClose: true,
                    buttonColor: Colors.white,
                    onTap: () {
                      overlayEntry.remove();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  void showCustomOverlay({
    required BuildContext context,
    required WidgetBuilder builder,
  }) {
    if (_overlayEntry != null) {
      hideOverlay();
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Builder(builder: builder),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideOverlay() {
    if (_overlayEntry != null && _overlayEntry!.mounted) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }

    _animationController?.dispose();
  }

  void hideDialog() {
    Navigator.of(context).pop();
  }

  void hideKeyboard() {
    if (context.mounted) {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}
