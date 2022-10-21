import 'package:excode/src/home/models/input_model.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/services/input_service.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomBarDialogWidget extends ConsumerStatefulWidget {
  const BottomBarDialogWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomBarDialogWidget> createState() =>
      _BottomBarDialogWidgetState();
}

class _BottomBarDialogWidgetState extends ConsumerState<BottomBarDialogWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _valueController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _valueController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(bottomBarButtonsStateProvider);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: ReorderableListView(
                header: Text('Reorder'),
                buildDefaultDragHandles: false,
                shrinkWrap: true,
                children: data
                    .map(
                      (e) => ReorderableDragStartListener(
                        key: Key(e.name),
                        index: data.indexOf(e),
                        child: Container(
                          color: ref.watch(themeStateProvider).secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              decoration: BoxDecoration(
                                color:
                                    ref.watch(themeStateProvider).primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(e.name),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: Icon(Icons.drag_handle),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    ref
                        .watch(bottomBarButtonsStateProvider.notifier)
                        .reorder(oldIndex, newIndex);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
