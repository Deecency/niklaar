import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';
import 'package:smart_rob/core/core.dart';
import 'package:smart_rob/screens/auth/sign_up/username_info.dart';
import 'package:smart_rob/screens/auth/success_screen.dart';

import '../../../core/validators/exceptions.dart';
import '../../../repositories/auth/auth_repo.dart';
import '../../../widgets/widgets.dart';
import 'sign_up.dart';

class PasswordInfo extends StatefulWidget {
  const PasswordInfo({super.key});

  @override
  State<PasswordInfo> createState() => _PasswordInfoState();
}

class _PasswordInfoState extends State<PasswordInfo> with GlobalHelper {
  String? _errorNew;
  String? _errorConfirm;
  final _newPassTC = TextEditingController();
  final _confirmPassTC = TextEditingController();

  final registerAsync = asyncSignal(AsyncData(null));

  Future<void> _register() async {
    try {
      registerAsync.value = AsyncState.loading();
      final username = usernameData.get();
      showLoadingOverlay(context: context);
      final res = await context.read<AuthRepository>().register(
        password: _newPassTC.text,
        passwordConfirmation: _confirmPassTC.text,
        userName: username?.username ?? '',
        referral: username?.referral ?? '',
      );
      hideOverlay();
      if (res.data != null) {
        if (mounted) {
          showSuccessSnack(context, text: res.data['data']['message']);
        }
        if (mounted) context.pushAndRemoveUntil(SuccessScreen(), (_) => false);

        registerAsync.value = AsyncState.data(res.data);
        return;
      }
      final error = res.exception?.getErrorMessage();
      if (mounted) showErrorSnack(context, text: error);
      registerAsync.value = AsyncState.error(BaseException(message: error));
    } catch (e, s) {
      registerAsync.value = AsyncState.error(e, s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive =
        _errorNew == null &&
        _errorConfirm == null &&
        _newPassTC.text.isNotEmpty &&
        _confirmPassTC.text.isNotEmpty;

    signUpState.value = isActive ? SignUpState.completed : SignUpState.password;

    return Column(
      children: [
        AppTextField(
          controller: _newPassTC,
          label: 'Create Password',
          hintText: '●●●●●●●●',
          obscureText: true,
          isExpands: false,
          hasError: _errorNew != null,
          errorMessage: _errorNew ?? '',
          onChanged: _validateNew,
        ),
        16.vSpace,
        AppTextField(
          controller: _confirmPassTC,
          label: 'Confirm Password',
          hintText: '●●●●●●●●',
          isExpands: false,
          obscureText: true,
          hasError: _errorConfirm != null,
          errorMessage: _errorConfirm ?? '',
          onChanged: _validateConfirm,
        ),
        16.vSpace,
        Spacer(),
        AppButton(
          text: 'Create account',
          status: isActive ? ABStatus.enabled : ABStatus.disabled,
          onTap: !isActive ? null : _register,
        ),
      ],
    );
  }

  void _validateNew(String val) {
    final error = Validators().validatePassword(val, null);
    if (error != null && error.isNotEmpty) {
      _errorNew = error;
    } else {
      _errorNew = null;
    }
    if (_newPassTC.text.length >= 8 &&
        _confirmPassTC.text.isNotEmpty &&
        _newPassTC.text != _confirmPassTC.text) {
      _errorConfirm = 'Passwords do not match';
    } else {
      _errorConfirm = null;
    }
    setState(() {});
  }

  void _validateConfirm(String val) {
    final err = Validators().validatePassword(val, _newPassTC.text);
    if (err != null && err.isNotEmpty) {
      _errorConfirm = err;
    } else {
      _errorConfirm = null;
    }
    setState(() {});
  }
}
