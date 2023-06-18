// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_commander/main.dart';
import 'package:flutter_commander/viewModels/result_screen_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_run/shell.dart';

final scriptProvider = StateProvider<String>((ref) => '');

/// 実行結果表示画面
class ResultScreen extends StatefulWidget {
  ResultScreen({super.key});

  final ResultScreenState resultScreenState = ResultScreenState();
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => resultScreenState;

  void executeCommand(WidgetRef ref) {
    resultScreenState.executeCommand(ref);
  }
}

class ResultScreenState extends State<ResultScreen> {
  RunningForm? runningForm;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      runningForm = const RunningForm();
      return runningForm!;
    });
  }

  void executeCommand(WidgetRef ref) {
    setState(() {
      runningForm?.execute(ref);
    });
  }
}

class RunningForm extends ConsumerWidget {
  const RunningForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(resultScreenViewModelProvider.notifier);

    return ref.watch(resultScreenViewModelProvider).when(
          data: (processResultList) {
            if (processResultList == null) {
              return const Text('実行開始');
            }

            // 実行結果を表示する
            return ListView.builder(
              itemCount: processResultList.length,
              itemBuilder: (BuildContext context, int index) {
                final outText = processResultList[index].outText.toString();
                return Text(outText);
              },
            );
          },
          error: (error, stack) {
            return Text(
              'errorが発生しました。 : ${error.toString()}',
              textAlign: TextAlign.center,
            );
          },
          loading: () => const Align(
            child: CircularProgressIndicator(),
          ),
        );
  }

  void execute(WidgetRef ref) {
    final script = ref.read(scriptProvider);
    final path = ref.read(projectInfoProvider).projectPath;
    ref.read(resultScreenViewModelProvider.notifier).execute(path, script);
  }
}
