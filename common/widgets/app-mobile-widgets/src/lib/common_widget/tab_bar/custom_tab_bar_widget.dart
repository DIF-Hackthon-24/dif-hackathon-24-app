import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/tab_bar/custom_tab_bar_widget_model.dart';

class CustomTabBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final CustomTabsBarWidgetAttribute attribute;
  CustomTabBarWidget({required this.attribute});

  @override
  Size get preferredSize => Size.zero;

  @override
  Widget build(BuildContext context) {
    return TabBarWithFlexibleTabs(
      attribute: attribute,
      child: TabBar(
        key: Key('CustomTabBarWidget_TabBar'),
        tabs: attribute.dataModel.tabTitleList
            .map<Tab>(
              (word) => Tab(
                key: Key('CustomTabBarWidget_Tab'),
                child: Text(
                  word,
                  key: Key('CustomTabBarWidget_Text'),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class TabBarWithFlexibleTabs extends StatefulWidget implements PreferredSizeWidget {
  final CustomTabsBarWidgetAttribute attribute;
  TabBarWithFlexibleTabs({
    required this.attribute,
    required this.child,
  });
  final TabBar child;
  @override
  Size get preferredSize => child.preferredSize;
  @override
  _TabBarWithFlexibleTabsState createState() => _TabBarWithFlexibleTabsState();
}

class _TabBarWithFlexibleTabsState extends State<TabBarWithFlexibleTabs> {
  final _tabs = <Widget>[];
  final _tabsKeys = <Widget, GlobalKey>{};
  var _tabsPadding = 0.0;

  void _updateTabBarPadding() => setState(() {
        final screenWidth = MediaQuery.of(context).size.width;
        final tabBarWidth = _tabsKeys.values.fold(0, (prev, tab) {
          final tabWidth = tab.currentContext!.size!.width;
            return (double.parse(prev.toString()) + tabWidth).toInt();
        });
        final availableSpaceForTabBar = screenWidth - (2 * widget.attribute.appearance.bottomLineSideMargin);
        _tabsPadding = tabBarWidth < availableSpaceForTabBar
            ? ((availableSpaceForTabBar - tabBarWidth) / widget.child.tabs.length) / 2
            : widget.child.labelPadding?.horizontal ?? 16.0;
        },
      );

  @override
  void initState() {
    super.initState();
    widget.child.tabs.forEach((tab) => _tabsKeys[tab] = GlobalKey());
    _tabs.addAll(widget.child.tabs.map((tab) => Container(key: _tabsKeys[tab], child: tab)));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateTabBarPadding());
  }

  @override
  Widget build(BuildContext context) {
    var _appearance = widget.attribute.appearance;
    return TabBarDecorator(
      attribute: widget.attribute,
      tabBar: TabBar(
        key: Key('CustomTabBarWidget_TabBar'),
        tabs: _tabs,
        labelPadding: EdgeInsets.symmetric(
          horizontal: _tabsPadding,
          vertical: widget.child.labelPadding?.vertical ?? 0,
        ),
        controller: widget.child.controller,
        indicatorWeight: _appearance.indicatorHeight,
        isScrollable: true,
      ),
    );
  }
}

class TabBarDecorator extends Container {
  TabBarDecorator({required this.attribute, required this.tabBar});

  final CustomTabsBarWidgetAttribute attribute;
  final TabBar tabBar;

  @override
  Widget build(BuildContext context) {
    var _appearance = attribute.appearance;
    return Container(
      key: Key('CustomTabBarWidget_Container'),
      child: Stack(
        key: Key('CustomTabBarWidget_Stack'),
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            key: Key('CustomTabBarWidget_ChildrenContainer'),
            margin: EdgeInsets.symmetric(
              horizontal: _appearance.bottomLineSideMargin,
            ),
            width: double.infinity,
            height: _appearance.bottomLineHeight,
          ),
          Column(
            key: Key('CustomTabBarWidget_ChildrenColumn'),
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                key: Key('CustomTabBarWidget_ColumnchildrenContainer'),
                height: _appearance.tabBarHeight,
                padding: EdgeInsets.symmetric(
                  horizontal: _appearance.bottomLineSideMargin,
                ),
                color: Colors.transparent,
                child: tabBar,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
