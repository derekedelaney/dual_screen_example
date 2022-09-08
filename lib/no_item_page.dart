import 'package:flutter/material.dart';

class NoItemPage extends StatelessWidget {
  const NoItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: const Center(
        child: Text('No item selected'),
      ),
    );
  }
}
