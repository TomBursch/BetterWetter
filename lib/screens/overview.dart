import 'package:BetterWetter/bloc/home/bloc.dart';
import 'package:BetterWetter/l10n/bwLocalizationDelegate.dart';
import 'package:BetterWetter/transitions/bwTransition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reorderables/reorderables.dart';
import 'package:BetterWetter/models/placemark.dart';

import 'search.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text(BWLocalizations.of(context).location),
            iconTheme: Theme.of(context).iconTheme,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  final Placemark result = await Navigator.push<Placemark>(
                    context,
                    bwTransition(
                      context: context,
                      builder: (context) => SearchScreen(),
                    ),
                  );
                  if (result != null) {
                    BlocProvider.of<HomeScreenBloc>(context)
                        .add(HomeScreenPlacemarkAdd(result));
                  }
                },
              ),
            ],
          ),
          BlocBuilder<HomeScreenBloc, HomeScreenState>(
            bloc: BlocProvider.of<HomeScreenBloc>(context),
            buildWhen: (previous, current) =>
                previous.locationEnabled != current.locationEnabled ||
                previous.localLocationName != current.localLocationName,
            builder: (context, state) => SliverList(
              delegate: SliverChildListDelegate([
                ListTile(
                  title: Text(state.localLocationName),
                  leading: Icon(Icons.location_on),
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
                (context, i) => ListTile(
                  title: Text(state.savedPlaces[i].toReadableString()),
                  leading: Icon(Icons.drag_handle),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => BlocProvider.of<HomeScreenBloc>(context)
                        .add(HomeScreenPlacemarkRemove(state.savedPlaces[i])),
                  ),
                ),
                childCount: state.savedPlaces.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
