import 'package:flutter_commander/models/project_info.dart';
import 'package:flutter_commander/models/tab_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainViewModelProvider =
    StateNotifierProvider.autoDispose<MainViewModel, AsyncValue<ListViewInfo?>>(
  (ref) => MainViewModelImpl(),
);

abstract class MainViewModel
    implements StateNotifier<AsyncValue<ListViewInfo?>> {
  void addTabInfo(ProjectInfoModel model);
}

class MainViewModelImpl extends StateNotifier<AsyncValue<ListViewInfo?>>
    implements MainViewModel {
  MainViewModelImpl() : super(const AsyncValue.data(null));

  final _tabInfo = ListViewInfo();

  @override
  void addTabInfo(ProjectInfoModel model) {
    state = const AsyncValue.loading();
    _tabInfo.projectInfoList.add(model);
    state = AsyncValue.data(_tabInfo);
  }
}
