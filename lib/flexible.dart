import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:velocity_x/velocity_x.dart';

class NetworkingPageHeader extends SliverPersistentHeaderDelegate {
  NetworkingPageHeader({
    required this.minExtent,
    required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    botaoMenu(),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.translate(
                            offset: Offset(
                                0,
                                ((razaoScroll(shrinkOffset) * -1) + 1) *
                                    80 *
                                    -1),
                            child: Opacity(
                              opacity: razaoScroll(shrinkOffset),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: razaoScroll(shrinkOffset) * 30,
                                ),
                                child: avatar(shrinkOffset),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: razaoScroll(
                                    shrinkOffset,
                                  ) *
                                  120,
                            ),
                            child: nome(shrinkOffset),
                          ),
                        ],
                      ),
                    ),
                    botaoHome(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
          ),
        ].reversed.toList());
  }

  Widget avatar(double shrinkOffset) {
    return VxBox()
        .coolGray100
        .bgImage(
          DecorationImage(
            image: NetworkImage(
                "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350"),
            fit: BoxFit.cover,
          ),
        )
        .square(radiusAvatar(shrinkOffset))
        .roundedFull
        .make();
  }

  Widget nome(double shrinkOffset) {
    return Center(
      child: Text(
        'Nome da pessoa',
        style: TextStyle(
          fontSize: textSize(shrinkOffset),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget botaoMenu() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.menu,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget botaoHome() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.home,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  double razaoScroll(double shrinkOffset, {double extent: 0}) {
    double multiply = max(
        0.0, 1.0 - max(0.0, (shrinkOffset - extent)) / (maxExtent - minExtent));
    return multiply;
  }

  double textSize(double shrinkOffset) {
    double minSize = 18;
    double maxSize = 26;

    double multiply = (razaoScroll(shrinkOffset) * -1) + 1;
    double calculo = maxSize - (multiply * (maxSize - minSize));
    return calculo;
  }

  double radiusAvatar(double shrinkOffset) {
    double minValue = 50;
    double maxValue = 110;

    double multiply = (razaoScroll(shrinkOffset) * -1) + 1;
    double calculo = maxValue - (multiply * (maxValue - minValue));

    return calculo;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
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
