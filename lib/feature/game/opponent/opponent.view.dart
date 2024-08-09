import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/button/button.dart';
import '../../shared/field/search_field.dart';
import '../../shared/player/avatar.widget.dart';
import '../../shared/player/displayname.widget.dart';
import '../../shared/player/rank.widget.dart';
import '../../shared/player/score.widget.dart';
import 'opponent.argument.dart';
import 'opponent.controller.dart';
import 'opponent.model.dart';

const _widthAvatar = 110.0;
const _widgetSize = 126.0;

class OpponentView extends ConsumerStatefulWidget {
  final OpponentArgument arguments;
  const OpponentView({required this.arguments, super.key});

  @override
  ConsumerState<OpponentView> createState() => _OpponentViewState();
}

class _OpponentViewState extends ConsumerState<OpponentView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final backgroundColor = const Color.fromARGB(255, 11, 122, 145);

  @override
  void initState() {
    Future.microtask(
        () async => await ref.read(opponentController.notifier).getOpponent(
              category: widget.arguments.category,
              group: widget.arguments.group,
              username: widget.arguments.username,
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final info = ref.watch(opponentController);
    // if (info == null) return const SizedBox();

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

  Widget _buildBody({OpponentModel? info}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSearch(displayName: info?.displayname),
        _buildOpponentPlayer(info: info),
        _buildDecline(),
      ],
    );
  }

  Widget _buildSearch({String? displayName}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 80),
      child: SearchField(
        label: displayName ?? 'Searching...',
        placeholder: 'Tap search button on the keyboard.',
        searchFieldBackground: Colors.transparent,
      ),
    );
  }

  Widget _buildOpponentPlayer({OpponentModel? info}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Stack(children: [
        const SizedBox(
          width: _widgetSize,
          height: _widgetSize,
        ),
        ScoreWidget(score: info?.score ?? 0, width: _widthAvatar),
        AvatarWidget(avatar: info?.avatar, width: _widthAvatar),
        DisplaynameWidget(displayname: info?.displayname, width: _widthAvatar),
        RankWidget(
          rank: info?.rank ?? 0,
          left: _widthAvatar,
        ),
      ]),
    );
  }

  Widget _buildDecline() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: outlinedButton(
        width: 128,
        title: 'Decline',
        color: Colors.white,
        alignment: CrossAxisAlignment.center,
        onPressed: () {},
      ),
    );
  }
}
