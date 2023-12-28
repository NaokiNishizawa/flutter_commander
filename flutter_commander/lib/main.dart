import 'package:flutter/material.dart';
import 'package:flutter_commander/base.dart';
import 'package:flutter_commander/models/project_info.dart';
import 'package:flutter_commander/pages/control.dart';
import 'package:flutter_commander/viewModels/main_view_model.dart';
import 'package:flutter_commander/widgets/organisms/input_project_info_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final projectInfoProvider = StateProvider<ProjectInfoModel>(
  (ref) => ProjectInfoModel(),
);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Commander',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Base(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ref.watch(mainViewModelProvider).when(
                  data: (listviewInfo) {
                    if (listviewInfo == null) {
                      return const Text('Projectを追加してください。');
                    }

                    return ListView.builder(
                      itemCount: listviewInfo.projectInfoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            ref.read(projectInfoProvider.notifier).update(
                                  (state) =>
                                      listviewInfo.projectInfoList[index],
                                );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Control(),
                              ),
                            );
                          },
                          child: ListViewInfoCell(
                            info: listviewInfo.projectInfoList[index],
                          ),
                        );
                      },
                    );
                  },
                  error: (error, stack) {
                    return const Text('エラーが発生しました。申し訳ありません。');
                  },
                  loading: () => const CircularProgressIndicator(),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          InputProjectInfoDialog(
            context: context,
            onOkTapped: (ProjectInfoModel model) {
              ref.read(mainViewModelProvider.notifier).addTabInfo(model);
            },
          ).show();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListViewInfoCell extends StatelessWidget {
  const ListViewInfoCell({super.key, required this.info});

  final ProjectInfoModel info;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
          width: double.infinity,
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  info.projectName,
                  textAlign: TextAlign.center,
                ),
              ),
              const Icon(Icons.navigate_next),
            ],
          )),
    );
  }
}
