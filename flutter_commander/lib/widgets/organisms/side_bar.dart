import 'package:flutter/material.dart';
import 'package:flutter_commander/base.dart';
import 'package:flutter_commander/models/side_bar_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideBar extends ConsumerWidget {
  SideBar({super.key});

  final items = [
    SideBarItem(
      'Home',
      Icons.home,
    ),
    SideBarItem(
      'Setting',
      Icons.settings,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 100,
      height: double.infinity,
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                ref
                    .read(selectedPageProvider.notifier)
                    .update((state) => index);
              },
              child: Card(
                child: Column(
                  children: [
                    Icon(items[index].icon),
                    Text(items[index].title),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
