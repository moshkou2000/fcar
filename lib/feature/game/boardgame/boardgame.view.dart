import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/dialog/dialog.dart';
import '../../shared/shared.module.dart';
import 'boardgame.argument.dart';
import 'boardgame.controller.dart';
import 'widgets/question.model.dart';

class BoardgameView extends ConsumerStatefulWidget {
  final BoardgameArgument arguments;
  const BoardgameView({required this.arguments, super.key});

  @override
  ConsumerState<BoardgameView> createState() => _OpponentViewState();
}

class _OpponentViewState extends ConsumerState<BoardgameView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final backgroundColor = const Color.fromARGB(255, 11, 122, 145);

  @override
  void initState() {
    Future.microtask(() => ref.read(boardgameController.notifier).init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final boardgameData = ref.watch(boardgameController);
    if (boardgameData == null) return const SizedBox();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        // TODO: after exit game, display the message:
        // 'You will not be allowed to play this game for sometimes.\n'
        // 'We will investigate the incident and will update you accordingly.',
        showDialogAt(
          context: context,
          title: 'Exit the game!!!',
          subtitle: 'Are you sure to exit the game?',
          primaryActionText: 'Exit',
          primaryActionColor: Colors.red,
          onPrimaryActionPressed: (observer) {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          secondaryActionText: 'Cancel',
          secondaryActionColor: Colors.grey,
          onSecondaryActionPressed: (observer) {
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        appBar: _buildAppBar(
            title:
                'You ${boardgameData.playerScore} - ${boardgameData.opponentScore} Opponent'),
        body: _buildBody(question: boardgameData.question),
      ),
    );
  }

  AppBar _buildAppBar({required String title}) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title),
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: const Icon(Icons.close),
        tooltip: 'Exit the game!!!',
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildBody({QuestionModel? question}) {
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
