import 'dart:io';

import 'package:flutter_commander/infra/shell_performer.dart';
import 'package:flutter_commander/widgets/organisms/result_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resultScreenViewModelProvider = StateNotifierProvider.autoDispose<
    ResultScreenViewModel, AsyncValue<List<ProcessResult>?>>(
  (ref) {
    final script = ref.read(scriptProvider);
    return ResultScreenViewModelImpl(
      ref.read(shellPerformerProvider),
    )..execute(script);
  },
);

abstract class ResultScreenViewModel
    implements StateNotifier<AsyncValue<List<ProcessResult>?>> {
  Future<void> execute(String script);
}

class ResultScreenViewModelImpl
    extends StateNotifier<AsyncValue<List<ProcessResult>?>>
    implements ResultScreenViewModel {
  ResultScreenViewModelImpl(this.shell) : super(const AsyncValue.data(null));

  final ShellPerformer shell;

  @override
  Future<void> execute(String script) async {
    try {
      state = const AsyncValue.loading();
      if (script.isEmpty) {
        state = const AsyncValue.data(null);
        return;
      }

      final result = await shell.execute(script);
      state = AsyncValue.data(result);
    } catch (err, stack) {
      state = AsyncValue.error(err.toString(), stack);
    }
  }
}
