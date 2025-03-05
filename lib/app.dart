import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';
import 'package:smart_rob/screens/auth/onboarding.dart';
import 'package:smart_rob/widgets/responsive_wrapper.dart';

import 'core/core.dart';

///This class holds Material App or Cupertino App
///with routing,theming and locale setup .
///Also responsive framework used for responsive application
///which auto resize or autoscale the app.
///
class Niklaar extends StatefulWidget {
  const Niklaar({super.key});

  @override
  State<Niklaar> createState() => _NiklaarState();
}

class _NiklaarState extends State<Niklaar> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppTheme>().currentTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppConfig.navigatorKey,
      title: 'Niklaar',
      theme: theme?.watch(context),
      localizationsDelegates: const [],
      builder: (context, child) {
        if (mounted) {
          ///Used for responsive design
          ///Here you can define breakpoint and how the responsive should work
          child = ResponsiveBreakPointWrapper(
            firstFrameWidget: Container(color: Colors.white),
            child: child!,
          );

          /// Add support for maximum text scale according to changes in
          /// accessibility in system settings
          final mediaQuery = MediaQuery.of(context);
          child = MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(
                mediaQuery.textScaleFactor.clamp(0, 1),
              ),
            ),
            child: child,
          );

          /// Added annotate region by default to switch according to theme which
          /// customize the system ui veray style
          child = AnnotatedRegion<SystemUiOverlayStyle>(
            value:
                theme?.isLightTheme == false
                    ? SystemUiOverlayStyle.dark.copyWith(
                      statusBarColor: AppColors.white.withValues(alpha: .4),
                      systemNavigationBarColor: AppColors.black,
                      systemNavigationBarDividerColor: Colors.black,
                      systemNavigationBarContrastEnforced: true,
                      systemNavigationBarIconBrightness: Brightness.light,
                    )
                    : SystemUiOverlayStyle.light.copyWith(
                      statusBarColor: AppColors.white.withValues(alpha: .4),
                      systemNavigationBarColor: AppColors.white,
                      systemNavigationBarContrastEnforced: true,
                      systemNavigationBarDividerColor: Colors.white,
                      systemNavigationBarIconBrightness: Brightness.light,
                    ),
            child: GestureDetector(onTap: hideKeyboard, child: child),
          );
        } else {
          child = const SizedBox.shrink();
        }

        return child;
      },
      home: OnboardingScreen(),
    );
  }
}
