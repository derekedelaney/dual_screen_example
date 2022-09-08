import 'package:dual_screen_example/pages_wrapper.dart';
import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  static const String path = '${PagesWrapper.path}/page3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: const Center(
        child: Text('This is the third page.'),
      ),
    );
  }
}
