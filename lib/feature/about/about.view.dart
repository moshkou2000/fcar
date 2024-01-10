import 'package:flutter/material.dart';

import 'about.argument.dart';

class AboutView extends StatefulWidget {
  const AboutView({required this.arguments, super.key});

  final AboutArgument arguments;

  @override
  State<AboutView> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutView> {
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
    return Center(
      child: Hero(
        tag: 'avatar',
        child: Image.asset(
          widget.arguments.playerInfo.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
