import 'package:flutter/material.dart';
import 'package:flutter_commander/enums/command_type.dart';
import 'package:flutter_commander/main.dart';
import 'package:flutter_commander/models/command_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Commands extends ConsumerStatefulWidget {
  const Commands({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommandsState();
}

class _CommandsState extends ConsumerState<Commands> {
  @override
  Widget build(BuildContext context) {
    final projectInfoModel = ref.read(projectInfoProvider);

    // FIXME 本当はFileなどから読み込めるようにすること ここから
    final doctorCmd = CommandInfoModel();
    doctorCmd.type = CommandType.doNotNeedAnything;
    doctorCmd.script = 'flutter doctor';

    final pubGetCmd = CommandInfoModel();
    pubGetCmd.type = CommandType.doNotNeedAnything;
    pubGetCmd.script = 'flutter pub get';

    final pubAddCmd = CommandInfoModel();
    pubAddCmd.type = CommandType.inputArgument;
    pubAddCmd.script = 'flutter pub add ';

    final List<CommandInfoModel> commandInfoModelList = [
      doctorCmd,
      pubGetCmd,
      pubAddCmd,
    ];
    // FIXME 本当はFileなどから読み込めるようにすること ここまで

    return ListView.builder(
      itemCount: commandInfoModelList.length,
      itemBuilder: (BuildContext context, int index) {
        final widget =
            commandInfoModelList[index].type == CommandType.doNotNeedAnything
                ? NoArgumentCmdForm(model: commandInfoModelList[index])
                : InputArgumentCmdForm(model: commandInfoModelList[index]);

        return Card(
          child: widget,
        );
      },
    );
  }
}

class NoArgumentCmdForm extends StatelessWidget {
  const NoArgumentCmdForm({super.key, required this.model});

  final CommandInfoModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(model.script),
        ),
        const Icon(Icons.directions_run),
      ],
    );
  }
}

class InputArgumentCmdForm extends StatelessWidget {
  InputArgumentCmdForm({super.key, required this.model});

  final CommandInfoModel model;
  final _argumentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Row(
          children: [
            Text(model.script),
            Expanded(
              child: TextFormField(
                controller: _argumentTextController,
                decoration: const InputDecoration(hintText: '追加するパッケージ名'),
              ),
            ),
          ],
        )),
        const Icon(Icons.directions_run),
      ],
    );
  }
}
