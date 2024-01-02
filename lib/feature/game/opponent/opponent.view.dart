import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/player.model.dart';
import '../../shared/button/button.dart';
import '../../shared/player/avatar.widget.dart';
import '../../shared/player/displayname.widget.dart';
import '../../shared/player/rank.widget.dart';
import '../../shared/player/score.widget.dart';
import 'opponent.argument.dart';
import 'opponent.controller.dart';

class OpponentView extends ConsumerStatefulWidget {
  const OpponentView({required this.arguments, super.key});

  final OpponentArgument arguments;

  @override
  ConsumerState<OpponentView> createState() => _OpponentPageState();
}

class _OpponentPageState extends ConsumerState<OpponentView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final backgroundColor = const Color.fromARGB(255, 11, 122, 145);

  @override
  Widget build(BuildContext context) {
    final info = ref.watch(opponentController);
    if (info == null) return const SizedBox();

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(title: widget.arguments.title),
      body: _buildBody(info: info),
    );
  }

  AppBar _buildAppBar({required String title}) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title),
      automaticallyImplyLeading: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildBody({PlayerModel? info}) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: <Widget>[
                _buildSearch(),
                const Spacer(flex: 2),
                _buildOpponentPlayer(info: info),
                const Spacer(flex: 2),
                _buildDecline(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearch() {
    return SearchBar(
      hintText: 'Tap search button on the keyboard.',
      onSubmitted: (value) {
        // TODO: lock & search
        ref.read(opponentController.notifier).onPressedSearch(
              username: value,
              category: widget.arguments.category,
              group: widget.arguments.group,
            );
      },
    );
  }

  Widget _buildOpponentPlayer({PlayerModel? info}) {
    if (info == null) return const SizedBox();

    return Stack(children: [
      const SizedBox(width: 300),
      ScoreWidget(playerInfo: info),
      AvatarWidget(playerInfo: info),
      DisplaynameWidget(playerInfo: info),
      RankWidget(playerInfo: info),
    ]);
  }

  Widget _buildDecline() {
    return outlinedButton(
      title: 'Decline',
      color: Colors.red,
      onPressed: () {},
    );
  }
}
