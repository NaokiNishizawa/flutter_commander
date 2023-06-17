import 'package:flutter/material.dart';
import 'package:flutter_commander/models/project_info.dart';
import 'package:flutter_commander/widgets/organisms/input_project_info_dialog.dart';
import 'package:process_run/shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Commander',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Commander Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var shell = Shell();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          InputProjectInfoDialog(
            context: context,
            onOkTapped: (ProjectInfoModel model) {},
          ).show();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
