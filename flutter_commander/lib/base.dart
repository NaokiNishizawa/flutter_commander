import 'package:flutter/material.dart';
import 'package:flutter_commander/pages/home.dart';
import 'package:flutter_commander/pages/setting.dart';
import 'package:flutter_commander/widgets/organisms/side_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleProvider = StateProvider<String>((ref) => 'Flutter Commander');
final selectedPageProvider = StateProvider<int>((ref) => 0);

// 全てのページのベースとなるWidget
class Base extends ConsumerWidget {
  const Base({super.key});

  Widget _showPage(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const Setting();
      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Text(
              ref.watch(titleProvider),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Expanded(
            child: Row(
              children: [
                SideBar(),
                const VerticalDivider(
                  color: Colors.grey,
                ),
                Expanded(
                  child: _showPage(
                    ref.watch(selectedPageProvider),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
