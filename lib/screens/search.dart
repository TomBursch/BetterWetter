import 'package:BetterWetter/bloc/userSearch/bloc.dart';
import 'package:BetterWetter/models/placemark.dart';
import 'package:BetterWetter/l10n/bwLocalizationDelegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key key,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SearchBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SearchBloc, SearchState>(
        bloc: _bloc,
        listenWhen: (previous, current) => current is SearchStateSelected,
        listener: (context, state) =>
            Navigator.of(context).pop((state as SearchStateSelected).selected),
        buildWhen: (previous, current) =>
            !(current is SearchStateSelected) && previous != current,
        builder: (context, state) => CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              title: Text(BWLocalizations.of(context).search),
              iconTheme: Theme.of(context).iconTheme,
              expandedHeight: 110,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 48),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.bottomCenter,
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: BWLocalizations.of(context).search,
                      fillColor: Theme.of(context).backgroundColor,
                    ),
                    onChanged: (s) => _bloc.add(SearchTerm(s)),
                  ),
                ),
              ),
            ),
            if (state is SearchStateResult)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, i) => placeMarkItem(
                    context,
                    state.placemark[i],
                  ),
                  childCount: state.placemark.length,
                )),
              ),
            if (state is SearchStateLoading)
              SliverPadding(
                padding: const EdgeInsets.only(top: 20),
                sliver: SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget placeMarkItem(BuildContext context, Placemark placemark) => FlatButton(
        child: Text(placemark.toReadableString()),
        onPressed: () => _bloc.add(SearchSelect(placemark)),
      );

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
