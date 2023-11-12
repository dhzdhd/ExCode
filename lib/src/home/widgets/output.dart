import 'package:excode/src/home/providers/output_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OutputWrapperWidget extends StatefulHookConsumerWidget {
  const OutputWrapperWidget({super.key});

  @override
  ConsumerState<OutputWrapperWidget> createState() =>
      _OutputWrapperWidgetState();
}

class _OutputWrapperWidgetState extends ConsumerState<OutputWrapperWidget> {
  @override
  Widget build(BuildContext context) {
    return const _OutputWidget();
  }
}

class _OutputWidget extends ConsumerWidget {
  const _OutputWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(futureOutputStateProvider);

    return provider.when(
      data: (data) => Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: ListView(
          children: [
            _OutputListItem(
                icon: Icons.code, title: 'Output', content: data.output),
            _OutputListItem(
                icon: Icons.error, title: 'Error', content: data.error),
          ],
        ),
      ),
      error: (err, st) => const SizedBox(
        child: Text('Error'),
      ),
      loading: () => const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _OutputListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _OutputListItem({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(icon),
              title: Text(title),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20),
                child: Text(content),
              ),
            )
          ],
        ),
      ),
    );
  }
}
