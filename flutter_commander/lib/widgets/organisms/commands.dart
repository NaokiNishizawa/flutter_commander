import 'package:flutter/material.dart';
import 'package:flutter_commander/enums/command_type.dart';
import 'package:flutter_commander/models/command_info_model.dart';
import 'package:flutter_commander/widgets/organisms/result_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Commands extends StatefulWidget {
  const Commands({super.key});

  @override
  State<StatefulWidget> createState() => _CommandsState();
}

class _CommandsState extends State<Commands> {
  @override
  Widget build(BuildContext context) {
    // FIXME 本当はFileなどから読み込めるようにすること ここから
    final doctorCmd = CommandInfoModel();
    doctorCmd.type = CommandType.doNotNeedAnything;
    doctorCmd.script = 'flutter doctor';

    final pubGetCmd = CommandInfoModel();
    pubGetCmd.type = CommandType.doNotNeedAnything;
    pubGetCmd.script = 'flutter pub get';

    final pubAddCmd = CommandInfoModel();
    pubAddCmd.type = CommandType.inputArgument;
    pubAddCmd.script = 'flutter pub add';

    final List<CommandInfoModel> commandInfoModelList = [
      doctorCmd,
      pubGetCmd,
      pubAddCmd,
    ];
    // FIXME 本当はFileなどから読み込めるようにすること ここまで

    return ListView.builder(
      itemCount: commandInfoModelList.length,
      itemBuilder: (BuildContext context, int index) {
        final infoModel = commandInfoModelList[index];
        final widget = infoModel.type == CommandType.doNotNeedAnything
            ? NoArgumentCmdForm(model: infoModel)
            : InputArgumentCmdForm(model: infoModel);

        return Card(
          child: widget,
        );
      },
    );
  }
}

class NoArgumentCmdForm extends ConsumerWidget {
  const NoArgumentCmdForm({super.key, required this.model});

  final CommandInfoModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(scriptProvider.notifier).update((state) => model.script);
      },
      child: SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(model.script),
            ),
            const Icon(Icons.directions_run),
          ],
        ),
      ),
    );
  }
}

class InputArgumentCmdForm extends ConsumerWidget {
  InputArgumentCmdForm({super.key, required this.model});

  final CommandInfoModel model;
  final _argumentTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        final packageName = _argumentTextController.text.toString();
        if (packageName.isEmpty) {
          // TODO 画面にダイアログを表示すること
          return;
        }

        final script = '${model.script} $packageName';
        ref.read(scriptProvider.notifier).update((state) => script);
      },
      child: Row(
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
      ),
    );
  }
}
