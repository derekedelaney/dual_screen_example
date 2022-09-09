import 'package:dual_screen/dual_screen.dart';
import 'package:dual_screen_example/context_extension.dart';
import 'package:dual_screen_example/no_item_page.dart';
import 'package:dual_screen_example/page_1.dart';
import 'package:dual_screen_example/page_2.dart';
import 'package:dual_screen_example/page_3.dart';
import 'package:flutter/material.dart';

class PagesWrapper extends StatefulWidget {
  const PagesWrapper({Key? key, required this.subRoute, this.settings})
      : super(key: key);
  static const path = '/pages';
  final String subRoute;
  final RouteSettings? settings;

  @override
  State<PagesWrapper> createState() => _PagesWrapperState();
}

class _PagesWrapperState extends State<PagesWrapper> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int? selectedIndex;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Page2.path.endsWith(widget.subRoute)) {
        _navigatorKey.currentState?.pushNamed(widget.subRoute);
      } else if (Page3.path.endsWith(widget.subRoute)) {
        _navigatorKey.currentState
            ?.pushNamed(Page2.path, arguments: widget.settings?.arguments);
        setState(() {
          selectedIndex =
              (widget.settings?.arguments as Map<String, int>)['index'];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TwoPane(
      startPane: Navigator(
        key: _navigatorKey,
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              Navigator.of(context).pop();
              return const Scaffold(
                body: Center(
                  child: Text('Not Found'),
                ),
              );
            },
          );
        },
        onGenerateRoute: (settings) {
          final name = settings.name!;
          if (Page1.path.endsWith(name) || name == '/') {
            return MaterialPageRoute(builder: (context) => const Page1());
          } else if (Page2.path.endsWith(name)) {
            final index = settings.arguments != null
                ? (settings.arguments as Map<String, int>)['index']
                : null;
            return MaterialPageRoute(
                builder: (context) => Page2(selectedIndex: index));
          } else if (Page3.path.endsWith(name)) {
            setState(() {
              selectedIndex = (settings.arguments as Map<String, int>)['index'];
            });
          }
          return null;
        },
      ),
      endPane: selectedIndex != null
          ? Page3(index: selectedIndex!)
          : const NoItemPage(),
      panePriority:
          context.isSmallScreen ? TwoPanePriority.start : TwoPanePriority.both,
      paneProportion: context.paneProportion,
    );
  }
}
