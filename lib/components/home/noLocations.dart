import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

class NoLocationsDisplay extends StatelessWidget {
  const NoLocationsDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle:
              extended.NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(right: 11),
          sliver: SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.arrow_upward),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Center(child: Text("No Locations")),
        )
      ],
    );
  }
}
