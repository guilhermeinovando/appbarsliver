import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'flexible.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              double minExtent =
                  kToolbarHeight + MediaQuery.of(context).padding.top;
              return [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: NetworkingPageHeader(
                    minExtent: minExtent,
                    maxExtent: 250.0,
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(icon: Icon(Icons.info), text: "Tab 1"),
                        Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
                        Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 3"),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                menuCreate(),
                menuCreate(),
                menuCreate(),
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
        children: List.generate(50, (index) {
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
