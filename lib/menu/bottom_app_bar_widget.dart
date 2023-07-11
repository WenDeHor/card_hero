import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              print('button tapped');
            },
            icon: const Icon(
              Icons.account_tree_outlined,
              color: Colors.brown,
            ),
            iconSize: 70.0,
          ),
          IconButton(
            onPressed: () {
              print('button tapped');
            },
            icon: const Icon(
              Icons.api,
              color: Colors.brown,
            ),
            iconSize: 70.0,
          ),
          IconButton(
            onPressed: () {
              print('button tapped');
            },
            icon: const Icon(
              Icons.add_chart,
              color: Colors.brown,
            ),
            iconSize: 70.0,
          ),
          IconButton(
            onPressed: () {
              print('button tapped');
            },
            icon: const Icon(
              Icons.adjust,
              color: Colors.brown,
            ),
            iconSize: 70.0,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}