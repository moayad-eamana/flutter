import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget StaggeredGridTileW(int crossA, double hi, Widget widget) {
  return StaggeredGridTile.extent(
      crossAxisCellCount: crossA, mainAxisExtent: hi, child: widget);
}
