import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_rob/widgets/custom_button.dart';
import 'package:smart_rob/widgets/page_wrapper.dart';

import '../../core/core.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Column(
        children: [
          Spacer(),
          SvgPicture.asset(
            'assets/icons/fa6-solid_circle-check.svg',
            height: 44.relHeight,
          ),
          24.vSpace,
          Text('Account Created', style: TextStyles.w600_20(context)),
          16.vSpace,
          Text(
            'Congratulations! Your Niklaar account has\nsuccessfully been created.',
            textAlign: TextAlign.center,
            style: TextStyles.w400_16(context),
          ),
          Spacer(flex: 4),
          AppButton(text: 'Go Home', onTap: () {}),
        ],
      ),
    );
  }
}
