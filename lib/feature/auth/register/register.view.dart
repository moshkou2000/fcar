import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcar_lib/config/extension/string.extension.dart';

import '../../../config/theme/theme_color.dart';
import '../../../config/theme/theme_font.dart';
import '../../../core/service/navigation/navigation_route.dart';
import '../../shared/shared.module.dart';
import 'register.controller.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterView> createState() => _SimpleRegisterScreenState();
}

class _SimpleRegisterScreenState extends ConsumerState<RegisterView> {
  final Color _backgroundColor = Colors.white;

  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  bool get isValid =>
      _email.isNotEmpty &&
      _password.isNotEmpty &&
      _confirmPassword.isNotEmpty &&
      ref.watch(registerController.notifier).formKey.currentState?.validate() ==
          true;

  @override
  void initState() {
    _email = '';
    _password = '';
    _confirmPassword = '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: ref.watch(registerController.notifier).formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _buildHeading(),
                        SizedBox(height: screenHeight * .09),
                        _buildEmailField(),
                        _buildPasswordField(),
                        _buildConfirmPasswordField(),
                        const SizedBox(height: 24),
                        _buildSignUpButton(),
                        SizedBox(height: screenHeight * .09),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _buildSignInButton(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Account,',
            style: ThemeFont.headingMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Sign up to get started!',
            style: ThemeFont.label500Large.copyWith(
              color: Colors.black.withOpacity(.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return SizedBox(
      height: 99,
      child: inputField(
        labelText: 'Email',
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) => setState(() => _email = value),
        validator: (value) =>
            value?.isNotEmpty == true && value?.isValidEmail != true
                ? 'Enter a valid email.'
                : null,
      ),
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
      height: 99,
      child: inputField(
        labelText: 'Password',
        obscureText: true,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) => setState(() => _password = value),
        validator: (value) =>
            value?.isNotEmpty == true && value?.isValidPassword != true
                ? 'Enter a valid password.'
                : null,
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return SizedBox(
      height: 99,
      child: inputField(
        labelText: 'Confirm Password',
        obscureText: true,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) => setState(() => _confirmPassword = value),
        validator: (value) => value?.isNotEmpty == true &&
                (value?.isValidPassword != true || value != _password)
            ? 'Enter same password.'
            : null,
        onSubmitted: (val) => _register(),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ObserverButton(
      buttonType: ButtonType.outlinedButton,
      onPressed: (observer) => _register(observer: observer),
      width: double.infinity,
      title: 'Sign Up',
      color: ThemeColor.button,
      alignment: CrossAxisAlignment.center,
      buttonState: isValid ? ButtonState.idle : ButtonState.disabled,
    );
  }

  Widget _buildSignInButton() {
    return textButton(
      onPressed: () =>
          Navigation.pushAndRemoveUntil(NavigationRoute.loginRoute),
      child: RichText(
        text: TextSpan(
          text: 'You have an account? ',
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: ThemeColor.button,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register({ButtonObserver? observer}) {
    observer?.setLoading();
    final isValid = ref.read(registerController.notifier).isValid;
    if (isValid) {
      ref
          .read(registerController.notifier)
          .register(email: _email, password: _password);
    }
    observer?.setIdle();
  }
}
