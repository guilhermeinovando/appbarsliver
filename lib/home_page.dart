import 'package:flutter/material.dart';

import 'flexible.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: NetworkingPageHeader(
                minExtent:
                    kToolbarHeight + MediaQuery.of(context).padding.top + 5,
                maxExtent: 250.0 + 50,
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(icon: Icon(Icons.info), text: "Tab 1"),
                    Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
                  ],
                ),
              ),
              pinned: true,
            ),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate((context, index) {
                String _title = "List item $index";
                return ListTile(
                  title: Text(_title),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Material(
      color: Theme.of(context).canvasColor,
      elevation: 4,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
