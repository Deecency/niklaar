import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:signals/signals_flutter.dart';
import 'package:smart_rob/core/core.dart';
import 'package:smart_rob/screens/auth/sign_up/password_info.dart';
import 'package:smart_rob/screens/auth/sign_up/select_country.dart';

import '../../../widgets/widgets.dart';
import 'basic_info.dart';
import 'username_info.dart';

final filteredList = countries.toSignal();
final showCountries = signal<bool>(false);
final selectedCountry = signal<Country?>(null);

void resetState() {
  showCountries.value = false;
  selectedCountry.value = null;
  filteredList.value = countries;
}

final signUpState = signal<SignUpState>(SignUpState.country);

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      canPop: false,
      resizeToAvoidBottomInset: false,
      child: Column(
        children: [
          34.vSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBackButton(
                onTap: () {
                  if (signUpState.watch(context) != SignUpState.country) {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            'Unsaved Data',
                            style: TextStyles.w600_16(context),
                          ),
                          content: Text(
                            'You will lose unsaved data. Do you want to continue?',
                            style: TextStyles.w400_14Black400,
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text(
                                'Cancel',
                                style: TextStyles.w500_12(context),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text(
                                'Continue',
                                style: TextStyles.w500_12(context),
                              ),
                              onPressed: () {
                                signUpState.value = SignUpState.country;
                                resetState();
                                context
                                  ..pop
                                  ..pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  resetState();
                  context.pop();
                },
              ),
              SvgPicture.asset('assets/logos/logo.svg', height: 24.relHeight),
              if (signUpState.watch(context) != SignUpState.completed)
                Text(
                  'Sign In',
                  style: TextStyles.w400_14(context).copyWith(
                    color: AppColors.secondary,
                    letterSpacing: -0.5,
                    height: 17.05 / 14,
                  ),
                ),
            ],
          ),
          28.vSpace,
          Text(
            switch (signUpState.watch(context)) {
              SignUpState.country => 'Select your country',
              _ => 'Let’s get you started',
            },
            style: TextStyles.w600_20(
              context,
            ).copyWith(color: AppColors.black, letterSpacing: -0.5),
          ),
          if (signUpState.watch(context) != SignUpState.country) ...[
            16.vSpace,
            Text(
              'Enter your details and create a password\nto set up your account',
              textAlign: TextAlign.center,
              style: TextStyles.w400_14(
                context,
              ).copyWith(color: AppColors.black, letterSpacing: -0.5),
            ),
            24.vSpace,
            Row(
              children: [
                _buildTab(
                  context,
                  name: 'Basic Info',
                  isActive: signUpState.watch(context) == SignUpState.basicInfo,
                  isCompleted:
                      signUpState.watch(context) == SignUpState.username ||
                      signUpState.watch(context) == SignUpState.password ||
                      signUpState.watch(context) == SignUpState.completed,
                ),
                9.5.hSpace,
                _buildTab(
                  context,
                  name: 'Username',
                  isActive: signUpState.watch(context) == SignUpState.username,
                  isCompleted:
                      signUpState.watch(context) == SignUpState.password ||
                      signUpState.watch(context) == SignUpState.completed,
                ),
                9.5.hSpace,
                _buildTab(
                  context,
                  name: 'Password',
                  isActive: signUpState.watch(context) == SignUpState.password,
                  isCompleted:
                      signUpState.watch(context) == SignUpState.completed,
                ),
              ],
            ),
            32.vSpace,
          ],
          Expanded(
            child: switch (signUpState.watch(context)) {
              SignUpState.country => CountryView(),

              SignUpState.basicInfo => BasicInfo(),

              SignUpState.username => UsernameInfo(),

              SignUpState.password || SignUpState.completed => PasswordInfo(),
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    bool isCompleted = false,
    required String name,
    required bool isActive,
  }) => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8.relHeight),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive || isCompleted ? AppColors.black : AppColors.white,
        border:
            isActive || isCompleted
                ? null
                : Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyles.w400_12(context).copyWith(
              color:
                  isActive || isCompleted
                      ? AppColors.white
                      : Color(0xff1E1E1E).withValues(alpha: 0.2),
            ),
          ),
          if (isCompleted) ...[
            4.hSpace,
            SvgPicture.asset(
              'assets/icons/gravity-ui_check.svg',
              height: 12.relHeight,
            ),
          ],
        ],
      ),
    ),
  );
}

enum SignUpState { country, basicInfo, username, password, completed }
