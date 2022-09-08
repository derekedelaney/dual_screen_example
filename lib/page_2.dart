import 'package:dual_screen_example/page_3.dart';
import 'package:dual_screen_example/pages_wrapper.dart';
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);
  static const String path = '${PagesWrapper.path}/page2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
        ),
        title: const Text('Page 2'),
      ),
      body: ListView.separated(
        itemBuilder: (context, i) => ListTile(
          title: Text('Nested $i'),
          subtitle: const Text('Some helpful text.'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pushNamed(Page3.path);
          },
        ),
        itemCount: 25,
        separatorBuilder: (context, i) => const Divider(height: 1),
      ),
    );
  }
}
