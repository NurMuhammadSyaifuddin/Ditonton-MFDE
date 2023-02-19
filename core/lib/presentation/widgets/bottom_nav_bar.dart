import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import '../pages/tvshow/home_tvshow_page.dart';
import '../pages/watchlist/watchlist_page.dart';

enum TypeBottomNav { movie, tvshow, watchlist }

class BottomNavBar extends StatefulWidget {
  final TypeBottomNav selected;

  const BottomNavBar({super.key, required this.selected});

  @override
  State<StatefulWidget> createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  int _selectedBottomNavBar = 0;

  void _changeSelectedBottomNavBar(int index) {
    setState(() {
      _selectedBottomNavBar = index;
    });

    if (_selectedBottomNavBar == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (_selectedBottomNavBar == 1) {
      Navigator.pushNamed(context, HomeTvShowPage.ROUTE_NAME);
    } else {
      Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
    }
  }

  @override
  Widget build(BuildContext context) => Theme(
      data: Theme.of(context).copyWith(canvasColor: kRichBlack),
      child: Container(
        decoration: const BoxDecoration(
          color: kRichBlack,
        ),
        child: BottomNavigationBar(
            unselectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 14),
            selectedLabelStyle: const TextStyle(color: kPrussianBlue, fontSize: 16),
            backgroundColor: kRichBlack,
            fixedColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: _selectedBottomNavBar,
            onTap: _changeSelectedBottomNavBar,
            items: [
              BottomNavigationBarItem(
                label:'Movie',
                  icon: widget.selected == TypeBottomNav.movie
                      ? const Icon(
                          Icons.movie,
                          color: kPrussianBlue,
                        )
                      : const Icon(
                          Icons.movie_outlined,
                          color: Colors.white,
                        )),
              BottomNavigationBarItem(
                label: 'Tv show',
                  icon: widget.selected == TypeBottomNav.tvshow
                      ? const Icon(
                    Icons.tv,
                    color: kPrussianBlue,
                  )
                      : const Icon(
                    Icons.tv_outlined,
                    color: Colors.white,
                  )),
              BottomNavigationBarItem(
                label: 'Watchlist'
                    '',
                  icon: widget.selected == TypeBottomNav.watchlist
                      ? const Icon(
                    Icons.save_alt,
                    color: kPrussianBlue,
                  )
                      : const Icon(
                    Icons.save_alt_outlined,
                    color: Colors.white,
                  ))
            ]),
      ));
}
