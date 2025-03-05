import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';
import 'package:smart_rob/core/core.dart';
import 'package:smart_rob/core/validators/exceptions.dart';
import 'package:smart_rob/repositories/auth/auth_repo.dart';

import '../../../widgets/widgets.dart';
import 'sign_up.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});
  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> with GlobalHelper {
  final _firstNameTC = TextEditingController();
  final _lastNameTC = TextEditingController();
  final _emailTC = TextEditingController();
  final _phoneNumberTC = TextEditingController();

  final registerAsync = asyncSignal(AsyncData(null));

  Future<void> _register() async {
    try {
      registerAsync.value = AsyncState.loading();
      showLoadingOverlay(context: context);
      final res = await context.read<AuthRepository>().registerStepOne(
        firstName: _firstNameTC.text,
        lastName: _lastNameTC.text,
        email: _emailTC.text,
        phoneNumber: _phoneNumberTC.text,
      );
      hideOverlay();
      if (res.data != null) {
        signUpState.value = SignUpState.username;
        if (mounted) {
          showSuccessSnack(context, text: res.data['data']['message']);
        }

        if (mounted) {
          context.read<LocalRepository>().saveAuthToken(
            token: res.data['data']['access_token'],
          );
        }
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
    final loading = registerAsync.watch(context).isLoading;

    final isActive =
        _firstNameTC.text.isNotEmpty &&
        Validators.isValidEmail(_emailTC.text) &&
        _lastNameTC.text.isNotEmpty &&
        _emailTC.text.isNotEmpty &&
        _phoneNumberTC.text.isNotEmpty;
    return Column(
      children: [
        AppTextField(
          controller: _firstNameTC,
          label: 'First Name',
          hintText: 'Stephen',
          onChanged: (_) => setState(() {}),
        ),
        16.vSpace,
        AppTextField(
          controller: _lastNameTC,
          label: 'Last Name',
          hintText: 'Reign',
          onChanged: (_) => setState(() {}),
        ),
        16.vSpace,
        AppTextField(
          controller: _emailTC,
          label: 'Email Address',
          hintText: 'stephenreign@gmail.com',
          hasError:
              _emailTC.text.isNotEmpty &&
              !Validators.isValidEmail(_emailTC.text),
          errorMessage:
              !Validators.isValidEmail(_emailTC.text)
                  ? 'Please enter a valid email'
                  : '',
          inputType: TextInputType.emailAddress,
          onChanged: (_) => setState(() {}),
        ),
        16.vSpace,
        AppTextField(
          controller: _phoneNumberTC,
          label: 'Phone Number',
          hintText: '000000000000',
          inputType: TextInputType.phone,
          onChanged: (_) => setState(() {}),
        ),

        Spacer(),
        AppButton(
          text: 'Continue',
          status:
              loading
                  ? ABStatus.loading
                  : isActive
                  ? ABStatus.enabled
                  : ABStatus.disabled,
          onTap:
              !isActive
                  ? null
                  : () {
                    _register();
                  },
        ),
      ],
    );
  }
}
