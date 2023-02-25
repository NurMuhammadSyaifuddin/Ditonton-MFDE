
import 'package:core/presentation/pages/watchlist/watchlist_movie.dart';
import 'package:core/presentation/pages/watchlist/watchlist_tvshow.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_nav_bar.dart';

class WatchlistPage extends StatefulWidget {

  const WatchlistPage({super.key});

  @override
  State<StatefulWidget> createState() => _WatchListPage();
}

class _WatchListPage extends State<WatchlistPage>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: const BottomNavBar(selected: TypeBottomNav.watchlist),
    appBar: AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: const Text('Ditonton'),
      actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context, ABOUT_ROUTE);
        }, icon: const Icon(Icons.info_outline))
      ],
      bottom: TabBar(
        controller: controller,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.greenAccent),
          tabs: const [
            Tab(
              icon: Icon(Icons.movie),
            ),
            Tab(
              icon: Icon(Icons.tv),
            ),
          ]),
    ),
    body: TabBarView(
      controller: controller,
        children: const [WatchlistMovie(), WatchlistTvShow()]),
  );
}
