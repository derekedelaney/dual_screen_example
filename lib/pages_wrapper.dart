import 'package:dual_screen/dual_screen.dart';
import 'package:dual_screen_example/context_extension.dart';
import 'package:dual_screen_example/no_item_page.dart';
import 'package:dual_screen_example/page_1.dart';
import 'package:dual_screen_example/page_2.dart';
import 'package:dual_screen_example/page_3.dart';
import 'package:flutter/material.dart';

class PagesWrapper extends StatefulWidget {
  const PagesWrapper({Key? key, required this.subRoute}) : super(key: key);
  static const path = '/pages';
  final String subRoute;

  @override
  State<PagesWrapper> createState() => _PagesWrapperState();
}

class _PagesWrapperState extends State<PagesWrapper> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  bool showPage3 = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Page2.path.endsWith(widget.subRoute)) {
        _navigatorKey.currentState?.pushNamed(widget.subRoute);
      } else if (Page3.path.endsWith(widget.subRoute)) {
        _navigatorKey.currentState?.pushNamed(Page2.path);
        setState(() {
          showPage3 = true;
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
            return MaterialPageRoute(builder: (context) => const Page2());
          } else if (Page3.path.endsWith(name)) {
            setState(() {
              showPage3 = true;
            });
          }
          return null;
        },
      ),
      endPane: Page3.path.endsWith(widget.subRoute) || showPage3
          ? const Page3()
          : const NoItemPage(),
      panePriority:
          context.isSmallScreen ? TwoPanePriority.start : TwoPanePriority.both,
      paneProportion: context.paneProportion,
    );
  }
}
