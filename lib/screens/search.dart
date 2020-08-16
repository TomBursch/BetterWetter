import 'package:BetterWetter/bloc/home/bloc.dart';
import 'package:BetterWetter/bloc/userSearch/bloc.dart';
import 'package:BetterWetter/models/placemark.dart';
import 'package:BetterWetter/l10n/bwLocalizationDelegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reorderables/reorderables.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key key,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc _bloc;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = SearchBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<SearchBloc, SearchState>(
          bloc: _bloc,
          listenWhen: (previous, current) => current is SearchStateSelected,
          listener: (context, state) {
            BlocProvider.of<HomeScreenBloc>(context).add(HomeScreenPlacemarkAdd(
                (state as SearchStateSelected).selected));
            _bloc.add(SearchTerm(""));
            FocusScope.of(context).requestFocus(FocusNode());
            _textEditingController.clear();
          },
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
                      controller: _textEditingController,
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
              if (state is SearchStateOverview) ...[
                BlocBuilder<HomeScreenBloc, HomeScreenState>(
                  bloc: BlocProvider.of<HomeScreenBloc>(context),
                  buildWhen: (previous, current) =>
                      previous.locationEnabled != current.locationEnabled ||
                      previous.localLocationName != current.localLocationName,
                  builder: (context, state) => SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 12),
                      ListTile(
                        title: Text(
                          state.localLocationName ??
                              BWLocalizations.of(context).location,
                        ),
                        leading: Icon(Icons.location_on),
                        onTap: () => Navigator.pop(context, 0),
                      ),
                    ]),
                  ),
                ),
                BlocBuilder<HomeScreenBloc, HomeScreenState>(
                  bloc: BlocProvider.of<HomeScreenBloc>(context),
                  buildWhen: (previous, current) =>
                      previous.savedPlaces != current.savedPlaces,
                  builder: (context, state) => ReorderableSliverList(
                    onReorder: (oldIndex, newIndex) =>
                        BlocProvider.of<HomeScreenBloc>(context).add(
                            HomeScreenPlacemarkReorder(
                                oldIndex: oldIndex, newIndex: newIndex)),
                    delegate: ReorderableSliverChildBuilderDelegate(
                      (context, i) => Dismissible(
                        key: ObjectKey(state.savedPlaces[i]),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) =>
                            BlocProvider.of<HomeScreenBloc>(context).add(
                                HomeScreenPlacemarkRemove(
                                    state.savedPlaces[i])),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        child: ListTile(
                          title: Text(state.savedPlaces[i].toReadableString()),
                          leading: Icon(Icons.drag_handle),
                          onTap: () => Navigator.pop(
                              context, i + (state.locationEnabled ? 1 : 0)),
                        ),
                      ),
                      childCount: state.savedPlaces.length,
                    ),
                  ),
                ),
              ]
            ],
          ),
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
