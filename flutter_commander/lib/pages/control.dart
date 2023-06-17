import 'package:flutter/material.dart';
import 'package:flutter_commander/main.dart';
import 'package:flutter_commander/widgets/organisms/commands.dart';
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

    final content = Column(
      children: [
        Text(
          projectInfoModel.projectPath,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        Expanded(
            child: Row(
          children: const [
            Expanded(
              child: Commands(),
            ),
            VerticalDivider(),
            Expanded(child: Text('右')),
          ],
        )),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Project[${projectInfoModel.projectName}] 操作画面'),
      ),
      body: content,
    );
  }
}
