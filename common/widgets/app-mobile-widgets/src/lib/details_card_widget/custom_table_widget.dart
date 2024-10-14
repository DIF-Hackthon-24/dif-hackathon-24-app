import 'package:flutter/material.dart';

/// any custom row widget can be provided inside table row
typedef IndexedWidgetBuilder = TableRow Function(
  BuildContext context,
  int index,
);

class _Constants{
  static const double scrollbarRadius = 10;
  static const double ten = 10;
  static const double twenty = 20;
  static const double scrollbarThickness = 4;
  static const Color scrollbarColor =  Color(0xFFACADAD);
}

/// Table with rows that can be passed in
class CustomTableWidget extends StatelessWidget {
  const CustomTableWidget({
    Key? key,
    required this.dataList,
    required this.rowBuilder,
    this.columnWidths,
  }) : super(key: key);

  final List dataList;
  final IndexedWidgetBuilder rowBuilder;
  final Map<int, TableColumnWidth>? columnWidths;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawScrollbar(
        thumbColor: _Constants.scrollbarColor,
        thumbVisibility: true,
        trackVisibility: true,
        thickness: _Constants.scrollbarThickness,
        scrollbarOrientation:  ScrollbarOrientation.right ,
        radius: Radius.circular(_Constants.scrollbarRadius),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: _Constants.twenty,
              right: _Constants.twenty,
              bottom: _Constants.ten,
            ),
            child: Table(
              columnWidths: columnWidths,
              children: List<TableRow>.generate(
                dataList.length,
                (index) => rowBuilder(context, index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
