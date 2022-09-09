import 'package:dual_screen_example/context_extension.dart';
import 'package:dual_screen_example/pages_wrapper.dart';
import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key, required this.index}) : super(key: key);

  static const String path = '${PagesWrapper.path}/page3';

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: context.isSmallScreen),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'This is the third page.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              'Nested $index',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
