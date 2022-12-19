import 'package:excode/src/home/models/char_model.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
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
    final data = ref.watch(snippetBarStateProvider);

    return Dialog(
      insetPadding: const EdgeInsets.all(50),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Consumer(builder: (context, ref, child) {
              return Expanded(
                child: ReorderableListView(
                  header: Row(
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
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AddSnippetDialogWidget(
                                              option: SnippetDialogOption.edit,
                                              oldModel: e,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref
                                              .watch(snippetBarStateProvider
                                                  .notifier)
                                              .delete(e.name);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: ReorderableDragStartListener(
                                          index: data.indexOf(e),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(Icons.drag_handle),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      ref
                          .watch(snippetBarStateProvider.notifier)
                          .reorder(oldIndex, newIndex);
                    });
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

enum SnippetDialogOption {
  add,
  edit,
}

class AddSnippetDialogWidget extends ConsumerStatefulWidget {
  final SnippetDialogOption option;
  final CharModel? oldModel;

  const AddSnippetDialogWidget({Key? key, required this.option, this.oldModel})
      : super(key: key);

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
    final _formKey = GlobalKey<FormState>();

    return SimpleDialog(
        title: Text(
          widget.option == SnippetDialogOption.edit
              ? 'Edit snippet'
              : 'Add a custom snippet',
        ),
        contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 16.0),
        children: [
          Form(
            key: _formKey,
            onChanged: () => _formKey.currentState!.validate(),
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
                          .contains(value)) {
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
                        if (_formKey.currentState!.validate()) {
                          if (widget.option == SnippetDialogOption.add) {
                            ref
                                .watch(snippetBarStateProvider.notifier)
                                .append(CharModel(
                                  name: _nameController.text,
                                  value: _valueController.text,
                                  length: int.parse(
                                    _lengthController.text,
                                  ),
                                ));
                          } else {
                            // setState(() {
                            ref.watch(snippetBarStateProvider.notifier).edit(
                                  oldData: widget.oldModel!,
                                  newData: CharModel(
                                    name: _nameController.text,
                                    value: _valueController.text,
                                    length: int.parse(
                                      _lengthController.text,
                                    ),
                                  ),
                                );
                            // });
                          }
                          Navigator.of(context).pop();
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
