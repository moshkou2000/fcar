import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/material.dart';

import '../auth/player.model.dart';
import 'about.argument.dart';

const heroTagAboutView = 'avatarAbout';

class AboutView extends StatefulWidget {
  const AboutView({required this.arguments, super.key});

  final AboutArgument arguments;

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          logger.debug(innerBoxIsScrolled);
          return [_buildAppBar(title: widget.arguments.title)];
        },
        body: _buildBody(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: _floatingActionButton(),
      // bottomNavigationBar: _bottomNavigationAppBar(),
    );
  }

  SliverAppBar _buildAppBar({required String title}) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.35,
      floating: false,
      pinned: true,
      stretch: true,
      automaticallyImplyLeading: true,
      backgroundColor: backgroundColor,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        )
      ],
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
      flexibleSpace:
          _buildFlexibleSpaceBar(playerInfo: widget.arguments.playerInfo),
    );
  }

  Widget _buildFlexibleSpaceBar({required PlayerModel playerInfo}) {
    return FlexibleSpaceBar(
      centerTitle: true,
      collapseMode: CollapseMode.parallax,
      titlePadding: const EdgeInsets.only(left: 0, bottom: 16),
      // title: _buildAppBarTitle(title: title),
      background: Stack(
        children: [
          // avatar
          Positioned.fill(
            child: Hero(
              tag: heroTagAboutView,
              child: Image.asset(
                widget.arguments.playerInfo.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Group
              Text(
                playerInfo.group,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Rank
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      'Rank ${playerInfo.rank}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // xp
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      'XP ${playerInfo.xp}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // level
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      'LVL ${playerInfo.level}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text('Item $index', textAlign: TextAlign.center));
      },
    );
  }
}
