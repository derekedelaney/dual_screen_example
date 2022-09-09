import 'package:dual_screen_example/context_extension.dart';
import 'package:dual_screen_example/page_1.dart';
import 'package:dual_screen_example/page_2.dart';
import 'package:dual_screen_example/page_3.dart';
import 'package:dual_screen_example/pages_wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == MyHomePage.path) {
          return MaterialPageRoute(
            builder: (context) =>
                const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        } else if (settings.name?.startsWith(PagesWrapper.path) ?? false) {
          final subPath = settings.name!.substring(PagesWrapper.path.length);
          final subRoute = subPath == '' ? '/' : subPath;
          return MaterialPageRoute(
            builder: (context) {
              if (context.isSmallScreen) {
                switch (settings.name) {
                  case Page1.path:
                    return const Page1();
                  case Page2.path:
                    return const Page2();
                  case Page3.path:
                    final index =
                        (settings.arguments as Map<String, int>)['index'];
                    return Page3(index: index!);
                }
              }
              return PagesWrapper(subRoute: subRoute, settings: settings);
            },
          );
        }
        return null;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  static const path = '/';
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Page 1'),
            subtitle: const Text('Navigate to Page 1'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed(
                Page1.path,
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Page 2'),
            subtitle: const Text('Navigate to Page 2'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed(
                Page2.path,
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Page 3'),
            subtitle: const Text('Navigate to Page 2 selecting Nested 3'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed(
                Page3.path,
                arguments: {'index': 3},
              );
            },
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
