import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extend;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:velocity_x/velocity_x.dart";

import 'flexible.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var tabBarHeight = primaryTabBar.preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var pinnedHeaderHeight = statusBarHeight + kToolbarHeight;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: extend.NestedScrollView(
            headerSliverBuilder: (context, bodyIsScrolled) {
              return [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: NetworkingPageHeader(
                    minExtent: pinnedHeaderHeight,
                    maxExtent: 250.0,
                  ),
                ),
              ];
            },
            pinnedHeaderSliverHeightBuilder: () => pinnedHeaderHeight,
            body: Column(
              children: <Widget>[
                TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(icon: Icon(Icons.info), text: "Tab 1"),
                    Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
                    Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 3"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      menuCreate(),
                      menuCreate(),
                      menuCreate(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container menuCreate() {
    return Container(
      child: Column(
        children: List.generate(18, (index) {
          String _title = "List item $index";
          return ListTile(
              onTap: (() {
                print('$_title');
              }),
              title: Text(_title));
        }),
      ).scrollVertical(),
    );
  }
}
