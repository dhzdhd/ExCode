import 'package:excode/src/home/models/snippet_model.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SnippetBarDialogWidget extends ConsumerStatefulWidget {
  const SnippetBarDialogWidget({super.key});

  @override
  ConsumerState<SnippetBarDialogWidget> createState() =>
      _BottomBarDialogWidgetState();
}

class _BottomBarDialogWidgetState
    extends ConsumerState<SnippetBarDialogWidget> {
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
    final data = ref.watch(snippetBarStateProvider);

    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Snippets',
            style: TextStyle(fontSize: 20),
          ),
          OutlinedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddSnippetDialogWidget(
                  option: SnippetDialogOption.add,
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          )
        ],
      ),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          width: 500,
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: ReorderableListView(
              buildDefaultDragHandles: false,
              shrinkWrap: true,
              children: data
                  .map(
                    (e) => Container(
                      key: Key(e.name),
                      color: ref.watch(themeStateProvider).secondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          decoration: BoxDecoration(
                            color: ref.watch(themeStateProvider).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  e.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: ReorderableDragStartListener(
                                  index: data.indexOf(e),
                                  child: PopupMenuButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.drag_handle),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: const Row(
                                            children: [
                                              Text('Edit'),
                                              Spacer(),
                                              Icon(Icons.edit)
                                            ],
                                          ),
                                          onTap: () {
                                            Future.delayed(
                                              const Duration(seconds: 0),
                                              () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AddSnippetDialogWidget(
                                                  option:
                                                      SnippetDialogOption.edit,
                                                  oldModel: e,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        PopupMenuItem(
                                          child: const Row(
                                            children: [
                                              Text('Delete'),
                                              Spacer(),
                                              Icon(Icons.delete)
                                            ],
                                          ),
                                          onTap: () {
                                            Future.delayed(
                                              const Duration(seconds: 0),
                                              () => showDialog(
                                                context: context,
                                                builder: ((context) =>
                                                    AlertDialog(
                                                      title: const Text(
                                                          'Confirm delete'),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            ref
                                                                .watch(
                                                                    snippetBarStateProvider
                                                                        .notifier)
                                                                .delete(e.name);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Okay'),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            );
                                          },
                                        )
                                      ];
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onReorder: (oldIndex, newIndex) async {
                await ref
                    .watch(snippetBarStateProvider.notifier)
                    .reorder(oldIndex, newIndex);
              },
            ),
          ),
        ),
      ],
    );
  }
}

enum SnippetDialogOption {
  add,
  edit,
}

class AddSnippetDialogWidget extends ConsumerStatefulWidget {
  final SnippetDialogOption option;
  final SnippetModel? oldModel;

  const AddSnippetDialogWidget(
      {super.key, required this.option, this.oldModel});

  @override
  ConsumerState<AddSnippetDialogWidget> createState() =>
      _AddSnippetDialogWidgetState();
}

class _AddSnippetDialogWidgetState
    extends ConsumerState<AddSnippetDialogWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _valueController;
  late final TextEditingController _lengthController;

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget.option == SnippetDialogOption.edit
          ? widget.oldModel!.name
          : '',
    );
    _valueController = TextEditingController(
      text: widget.option == SnippetDialogOption.edit
          ? widget.oldModel!.value
          : '',
    );
    _lengthController = TextEditingController(
      text: widget.option == SnippetDialogOption.edit
          ? widget.oldModel!.length.toString()
          : '1',
    );
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
    final formKey = GlobalKey<FormState>();

    return SimpleDialog(
        title: Text(
          widget.option == SnippetDialogOption.edit
              ? 'Edit snippet'
              : 'Add a custom snippet',
        ),
        contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 16.0),
        children: [
          Form(
            key: formKey,
            onChanged: () => formKey.currentState!.validate(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ' Enter a string!';
                      } else if (value.length > 10) {
                        return 'Max length of 10 allowed!';
                      } else if (ref
                              .read(snippetBarStateProvider)
                              .map((e) => e.name)
                              .contains(value) &&
                          widget.option == SnippetDialogOption.add) {
                        return 'Duplicate names not allowed!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: TextFormField(
                    minLines: null,
                    maxLines: 2,
                    controller: _valueController,
                    decoration: const InputDecoration(labelText: 'Value'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: TextFormField(
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Length'),
                    validator: (value) {
                      final data = int.tryParse(value.toString());
                      if (data == null) {
                        return 'Enter an integer!';
                      } else if (data > 30) {
                        return 'Max value of 30 allowed!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (widget.option == SnippetDialogOption.add) {
                            await ref
                                .watch(snippetBarStateProvider.notifier)
                                .append(SnippetModel(
                                  name: _nameController.text,
                                  value: _valueController.text,
                                  length: int.parse(
                                    _lengthController.text,
                                  ),
                                ));
                          } else {
                            await ref
                                .watch(snippetBarStateProvider.notifier)
                                .edit(
                                  oldData: widget.oldModel!,
                                  newData: SnippetModel(
                                    name: _nameController.text,
                                    value: _valueController.text,
                                    length: int.parse(
                                      _lengthController.text,
                                    ),
                                  ),
                                );
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: const Text('Save', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                )
              ],
            ),
          )
        ]);
  }
}
