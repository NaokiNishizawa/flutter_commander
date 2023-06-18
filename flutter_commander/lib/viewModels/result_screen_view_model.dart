import 'dart:io';

import 'package:flutter_commander/infra/shell_performer.dart';
import 'package:flutter_commander/main.dart';
import 'package:flutter_commander/models/project_info.dart';
import 'package:flutter_commander/widgets/organisms/result_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resultScreenViewModelProvider = StateNotifierProvider.autoDispose<
    ResultScreenViewModel, AsyncValue<List<ProcessResult>?>>(
  (ref) {
    final script = ref.read(scriptProvider);
    final path = ref.read(projectInfoProvider).projectPath;
    return ResultScreenViewModelImpl(
      ref.read(shellPerformerProvider),
    )..execute(path, script);
  },
);

abstract class ResultScreenViewModel
    implements StateNotifier<AsyncValue<List<ProcessResult>?>> {
  Future<void> execute(String runningPath, String script);
}

class ResultScreenViewModelImpl
    extends StateNotifier<AsyncValue<List<ProcessResult>?>>
    implements ResultScreenViewModel {
  ResultScreenViewModelImpl(this.shell) : super(const AsyncValue.data(null));

  final ShellPerformer shell;

  @override
  Future<void> execute(String runningPath, String script) async {
    try {
      state = const AsyncValue.loading();
      if (script.isEmpty) {
        state = const AsyncValue.data(null);
        return;
      }

      final result = await shell.execute(runningPath, script);
      state = AsyncValue.data(result);
    } catch (err, stack) {
      state = AsyncValue.error(err.toString(), stack);
    }
  }

  @override
  Future<void> runCdProjectPath(ProjectInfoModel model) async {
    return;
  }
}
