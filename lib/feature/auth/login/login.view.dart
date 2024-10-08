import 'package:fcar_lib/config/extension/string.extension.dart';
import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constant/env.constant.dart';
import '../../../config/theme/theme_color.dart';
import '../../../config/theme/theme_font.dart';
import '../../../core/service/navigation/navigation_route.dart';
import '../../shared/shared.module.dart';
import 'login.controller.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  @override
  ConsumerState<LoginView> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends ConsumerState<LoginView> {
  final Color _backgroundColor = Colors.white;
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  bool get isValid =>
      _username.isNotEmpty &&
      _password.isNotEmpty &&
      _formKey.currentState?.validate() == true;

  @override
  void initState() {
    if (kDebugMode) {
      setState(() {
        _username = EnvConstant.username;
        _password = EnvConstant.password;
      });
      logger.info('_username: $_username, _password: $_password');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: _appBar(title: ''),
      body: _buildBody(),
    );
  }

  AppBar? _appBar({required String title}) {
    return AppBar(
      backgroundColor: Colors.amber,
      title: Text(title),
      automaticallyImplyLeading: false,
      // shape: CurvedAppbarShape(),
      leading: const Icon(Icons.menu),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildBody() {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: ShapeDecoration(
                          color: Colors.amber,
                          shape: CurvedAppbarShape(),
                        ),
                      ),
                      _buildHeading(),
                      SizedBox(height: screenHeight * .09),
                      _buildUsernameField(),
                      _buildPasswordField(),
                      const SizedBox(height: 24),
                      _buildSignInButton(),
                      SizedBox(height: screenHeight * .09),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _buildSignUpButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: ThemeFont.headingMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to continue!',
              style: ThemeFont.label500Large.copyWith(
                color: Colors.black.withOpacity(.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 99,
        child: inputField(
          initialValue: _username,
          labelText: 'Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: [AutofillHints.email],
          onChanged: (value) => setState(() => _username = value),
          validator: (value) =>
              value?.isNotEmpty == true && value?.isValidEmail != true
                  ? 'Enter a valid email.'
                  : null,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          SizedBox(
            height: 104,
            child: inputField(
              initialValue: _password,
              labelText: 'Password',
              obscureText: true,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofillHints: [AutofillHints.password],
              onChanged: (value) => setState(() => _password = value),
              validator: (value) =>
                  value?.isNotEmpty == true && value!.isValidPassword != true
                      ? 'Enter a valid password.'
                      : null,
              onSubmitted: (value) => _login(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: textButton(
              title: 'Forgot Password?',
              onPressed: () {
                logger.info('Pressed Forgot Password');
              },
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ObserverButton(
        buttonType: ButtonType.outlinedButton,
        onPressed: (observer) => _login(observer: observer),
        width: double.infinity,
        title: 'Sign In',
        color: ThemeColor.button,
        alignment: CrossAxisAlignment.center,
        buttonState: isValid ? ButtonState.idle : ButtonState.disabled,
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: textButton(
        onPressed: () =>
            Navigation.pushAndRemoveUntil(NavigationRoute.registerRoute),
        child: RichText(
          text: TextSpan(
            text: 'Do not have an account? ',
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: ThemeColor.button,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login({ButtonObserver? observer}) async {
    observer?.setLoading();
    if (isValid) {
      await ref
          .read(loginController.notifier)
          .onPressedSignIn(username: _username, password: _password);
    }
    observer?.setIdle();
  }
}
