import 'package:flutter/material.dart';
import 'package:flutter_commander/main.dart';
import 'package:flutter_commander/widgets/organisms/commands.dart';
import 'package:flutter_commander/widgets/organisms/result_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Control extends ConsumerStatefulWidget {
  const Control({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ControlState();
}

class _ControlState extends ConsumerState<Control>
    implements CommandsActionCallBack {
  final resultScreen = ResultScreen();
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
          children: [
            Expanded(
              child: Commands(callback: this),
            ),
            const VerticalDivider(),
            Expanded(
              child: resultScreen,
            ),
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

  @override
  void commandTapped() {
    resultScreen.executeCommand(ref);
  }
}
