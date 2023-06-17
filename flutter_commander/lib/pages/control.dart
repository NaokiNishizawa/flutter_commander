import 'package:flutter/material.dart';
import 'package:flutter_commander/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Control extends ConsumerStatefulWidget {
  const Control({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ControlState();
}

class _ControlState extends ConsumerState<Control> {
  @override
  Widget build(BuildContext context) {
    final projectInfoModel = ref.read(projectInfoProvider);

    final content = Text(projectInfoModel.projectPath); // TODO ここを変更していく

    return Scaffold(
      appBar: AppBar(
        title: Text('Project[${projectInfoModel.projectName}] 操作画面'),
      ),
      body: content,
    );
  }
}
