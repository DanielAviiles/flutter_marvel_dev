import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes de Marvel'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
    );
  }
}
