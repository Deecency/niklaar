import 'package:flutter/material.dart';
import 'package:signals/signals.dart';
import 'package:smart_rob/core/core.dart';

import '../../../widgets/widgets.dart';
import 'sign_up.dart';

typedef UserNameData = ({String username, String referral});

final usernameData = signal<UserNameData?>(null);

class UsernameInfo extends StatefulWidget {
  const UsernameInfo({super.key});

  @override
  State<UsernameInfo> createState() => _UsernameInfoState();
}

class _UsernameInfoState extends State<UsernameInfo> {
  final _userNameTC = TextEditingController();
  final _referralCodeTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: _userNameTC,
          label: 'Your Preferred Username',
          hintText: '@username',
          onChanged: (_) => setState(() {}),
        ),
        16.vSpace,
        AppTextField(
          controller: _referralCodeTC,
          label: 'Referral code',
          hintText: 'Optional',
          onChanged: (_) => setState(() {}),
        ),
        16.vSpace,
        Spacer(),
        AppButton(
          text: 'Continue',
          status:
              _userNameTC.text.isNotEmpty
                  ? ABStatus.enabled
                  : ABStatus.disabled,
          onTap:
              _userNameTC.text.isEmpty
                  ? null
                  : () {
                    usernameData.value = (
                      username: _userNameTC.text,
                      referral: _referralCodeTC.text,
                    );
                    signUpState.value = SignUpState.password;
                  },
        ),
      ],
    );
  }
}
