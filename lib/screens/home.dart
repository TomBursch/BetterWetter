import 'dart:math';

import 'package:BetterWetter/bloc/home/bloc.dart';
import 'package:BetterWetter/components/home/noLocations.dart';
import 'package:BetterWetter/components/home/weatherDisplay.dart';
import 'package:BetterWetter/l10n/bwLocalizationDelegate.dart';
import 'package:BetterWetter/screens/search.dart';
import 'package:BetterWetter/screens/settings.dart';
import 'package:BetterWetter/themes/styles.dart';
import 'package:BetterWetter/transitions/bwTransition.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  PageController _pageController = PageController();
  HomeScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = HomeScreenBloc();
    _pageController.addListener(() {
      _bloc.add(HomeScreenLocationChange(_pageController.page.round()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocProvider<HomeScreenBloc>.value(
          value: _bloc,
          child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            bloc: _bloc,
            builder: (context, state) => Stack(
              children: [
                extended.NestedScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) =>
                          <Widget>[
                    SliverOverlapAbsorber(
                      handle: extended.NestedScrollView
                          .sliverOverlapAbsorberHandleFor(context),
                      sliver: SliverAppBar(
                        backgroundColor: Theme.of(context).appBarTheme.color,
                        iconTheme: Theme.of(context).iconTheme,
                        leading: IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () => Navigator.push(
                            context,
                            bwTransition(
                              context: context,
                              builder: (context) => SettingsScreen(),
                            ),
                          ),
                        ),
                        centerTitle: true,
                        actions: [
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () async {
                              final newIndex = await Navigator.push<int>(
                                context,
                                bwTransition(
                                  context: context,
                                  builder: (context) => BlocProvider.value(
                                    value: _bloc,
                                    child: SearchScreen(),
                                  ),
                                ),
                              );
                              if (newIndex != null)
                                _pageController.jumpToPage(newIndex);
                            },
                          ),
                        ],
                        title: ((state.locationEnabled ? 1 : 0) +
                                    state.savedPlaces.length <=
                                1)
                            ? SmoothPageIndicator(
                                controller: _pageController,
                                count: (state.locationEnabled ? 1 : 0) +
                                    state.savedPlaces.length,
                                effect: WormEffect(
                                  dotColor: Theme.of(context)
                                      .iconTheme
                                      .color
                                      .withAlpha(50),
                                  activeDotColor:
                                      Theme.of(context).iconTheme.color,
                                  dotHeight: 10,
                                  dotWidth: 10,
                                ),
                              )
                            : null,
                        stretch: true,
                        expandedHeight: 110,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                state.selectedLocationName ??
                                    BWLocalizations.of(context).location,
                                style: Theme.of(context).textTheme.headline1,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  body: PageView.builder(
                    controller: _pageController,
                    physics: BouncingScrollPhysics(),
                    itemCount: max(
                        1,
                        (state.locationEnabled ? 1 : 0) +
                            state.savedPlaces.length),
                    itemBuilder: (context, i) {
                      if (i == 0 && state.locationEnabled) {
                        return WeatherDisplay();
                      } else if (i == 0 && true) return NoLocationsDisplay();
                      if (state.locationEnabled) i--;
                      return WeatherDisplay(location: state.savedPlaces[i]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
