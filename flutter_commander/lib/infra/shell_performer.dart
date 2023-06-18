import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_run/shell.dart';

final shellPerformerProvider = Provider(
  (ref) => ShellPerformerImpl(),
);

abstract class ShellPerformer {
  Future<List<ProcessResult>> execute(String inputDirPath, String script);
}

class ShellPerformerImpl extends ShellPerformer {
  final shell = Shell();

  @override
  Future<List<ProcessResult>> execute(
      String inputDirPath, String script) async {
    final cdShell = shell.cd(inputDirPath);
    return cdShell.run(script);
  }
}
