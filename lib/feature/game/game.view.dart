import 'package:flutter/material.dart';

import 'game.argument.dart';

class GameView extends StatefulWidget {
  const GameView({required this.arguments, super.key});

  final GameArgument arguments;

  @override
  State<GameView> createState() => _LeagueViewState();
}

class _LeagueViewState extends State<GameView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final backgroundColor = const Color.fromARGB(255, 11, 122, 145);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(title: widget.arguments.title),
      body: _buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: _floatingActionButton(),
      // bottomNavigationBar: _bottomNavigationAppBar(),
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

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: const Column(
              children: <Widget>[],
            ),
          ),
        );
      },
    );
  }
}
