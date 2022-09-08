import 'package:dual_screen_example/page_2.dart';
import 'package:dual_screen_example/pages_wrapper.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);
  static const String path = '${PagesWrapper.path}/page1';

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
        title: const Text('Page 1'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Page 2'),
            subtitle: const Text('Navigate to Page 2'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed(Page2.path);
            },
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
