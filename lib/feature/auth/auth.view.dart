import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/service/localization/localization.dart';
import '../shared/empty.view.dart';
import 'auth.controller.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  @override
  void initState() {
    Future.microtask(() => ref.read(authController.notifier).authentication());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EmptyView(
      illustration: const Icon(
        Icons.login,
        size: 77,
      ),
      // SvgPicture.asset(
      //   AssetConstant.emptyStates,
      //   fit: BoxFit.fitHeight,
      //   alignment: Alignment.center,
      //   width: 200,
      // ),
      title: Localization.authentication,
      subtitle: ref.watch(authController),
    );
  }
}
