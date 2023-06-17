import 'package:flutter/material.dart';
import 'package:flutter_commander/models/project_info.dart';

class InputProjectInfoDialog {
  InputProjectInfoDialog({required this.onOkTapped, required this.context});

  final void Function(ProjectInfoModel) onOkTapped;
  final BuildContext context;
  final _projectNameTextController = TextEditingController();
  final _projectPathTextController = TextEditingController();

  void show() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Project情報を入力してください。'),
        content: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextFormField(
                controller: _projectNameTextController,
                decoration: const InputDecoration(
                  hintText: 'Project Name',
                ),
              ),
              TextFormField(
                controller: _projectPathTextController,
                decoration: const InputDecoration(
                  hintText: 'Project Path',
                ),
              )
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              final model = ProjectInfoModel();
              model.projectName = _projectNameTextController.text.toString();
              model.projectPath = _projectPathTextController.text.toString();
              onOkTapped(model);

              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
