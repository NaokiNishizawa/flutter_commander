// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_commander/viewModels/result_screen_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          data: (processResult) {
            if (processResult == null) {
              return const Text('実行開始');
            }

            // TODO 実際の結果を表示する
            return const Text('実行完了');
          },
          error: (error, stack) {
            return Text(
              'errorが発生しました。 : ${error.toString()}',
              textAlign: TextAlign.center,
            );
          },
          loading: () => const CircularProgressIndicator(),
        );
  }

  void execute(WidgetRef ref) {
    final script = ref.read(scriptProvider);
    ref.read(resultScreenViewModelProvider.notifier).execute(script);
  }
}
