import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/feed.dart';
import 'feed_labels.dart';
import 'feed_providers.dart';

/// Futtermittel verwalten (für alle Pferde gemeinsam).
class FeedItemsScreen extends ConsumerWidget {
  const FeedItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final items = ref.watch(feedItemsProvider).value ?? const <FeedItem>[];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.feedItems)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => editFeedItem(context, ref, null),
        icon: const Icon(Icons.add),
        label: Text(l10n.feedItemNew),
      ),
      body: items.isEmpty
          ? EmptyState(
              icon: Icons.grass_outlined,
              title: l10n.feedItemsEmpty,
              message: l10n.feedDisclaimer,
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                for (final i in items)
                  ListTile(
                    title: Text(i.name),
                    subtitle: Text(
                      [
                        categoryName(l10n, i.category),
                        unitName(l10n, i.unit),
                        if (i.stock != null)
                          '${l10n.feedItemStockLabel}: '
                              '${Fmt.decimal(i.stock!)} ${unitName(l10n, i.unit)}',
                      ].join(' · '),
                    ),
                    onTap: () => editFeedItem(context, ref, i),
                    trailing: IconButton(
                      tooltip: l10n.actionDelete,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _remove(context, ref, i),
                    ),
                  ),
              ],
            ),
    );
  }

  Future<void> _remove(BuildContext context, WidgetRef ref, FeedItem i) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showConfirmDialog(
      context,
      title: l10n.feedItemRemoveTitle(i.name),
      message: l10n.feedItemRemoveText,
      confirmLabel: l10n.actionRemove,
      destructive: true,
    );
    if (!ok) return;
    final deleted = await ref.read(feedRepositoryProvider).removeItem(i.id);
    messenger.showSnackBar(
      SnackBar(
        content: Text(deleted ? l10n.feedItemRemoved : l10n.feedItemArchived),
      ),
    );
  }
}

/// Dialog für ein neues ([item] == null) oder vorhandenes Futtermittel.
/// Gibt die ID zurück (oder `null`).
Future<String?> editFeedItem(
  BuildContext context,
  WidgetRef ref,
  FeedItem? item,
) async {
  final result = await showDialog<FeedItem>(
    context: context,
    builder: (_) => _ItemDialog(item: item),
  );
  if (result == null) return null;
  return ref.read(feedRepositoryProvider).saveItem(result);
}

class _ItemDialog extends StatefulWidget {
  const _ItemDialog({this.item});
  final FeedItem? item;

  @override
  State<_ItemDialog> createState() => _ItemDialogState();
}

class _ItemDialogState extends State<_ItemDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.item?.name);
  late final _notes = TextEditingController(text: widget.item?.notes);
  late final _stock = TextEditingController(
    text: widget.item?.stock == null ? '' : Fmt.decimal(widget.item!.stock!),
  );
  late final _threshold = TextEditingController(
    text: widget.item?.lowStockThreshold == null
        ? ''
        : Fmt.decimal(widget.item!.lowStockThreshold!),
  );
  late FeedCategory _category = widget.item?.category ?? FeedCategory.raufutter;
  late FeedUnit _unit = widget.item?.unit ?? FeedUnit.kg;

  @override
  void dispose() {
    for (final c in [_name, _notes, _stock, _threshold]) {
      c.dispose();
    }
    super.dispose();
  }

  String? _number(String? v, AppLocalizations l10n) {
    final t = v?.trim() ?? '';
    if (t.isEmpty) return null;
    final n = Fmt.parseDecimal(t);
    return (n == null || n < 0) ? l10n.fieldInvalidNumber : null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.item == null ? l10n.feedItemNew : l10n.feedItemEdit),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _name,
              autofocus: widget.item == null,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: '${l10n.feedItemName} *'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<FeedCategory>(
              initialValue: _category,
              decoration: InputDecoration(labelText: l10n.feedItemCategory),
              items: [
                for (final c in FeedCategory.values)
                  DropdownMenuItem(
                    value: c,
                    child: Text(categoryName(l10n, c)),
                  ),
              ],
              onChanged: (c) => setState(() => _category = c ?? _category),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<FeedUnit>(
              initialValue: _unit,
              decoration: InputDecoration(labelText: l10n.feedItemUnit),
              items: [
                for (final u in FeedUnit.values)
                  DropdownMenuItem(value: u, child: Text(unitName(l10n, u))),
              ],
              onChanged: (u) => setState(() => _unit = u ?? _unit),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _stock,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.feedItemStock,
                suffixText: unitName(l10n, _unit),
              ),
              validator: (v) => _number(v, l10n),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _threshold,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.feedItemThreshold,
                suffixText: unitName(l10n, _unit),
              ),
              validator: (v) => _number(v, l10n),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notes,
              decoration: InputDecoration(labelText: l10n.feedItemNotes),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(
              context,
              FeedItem(
                id: widget.item?.id ?? '',
                name: _name.text,
                category: _category,
                unit: _unit,
                notes: _notes.text,
                stock: Fmt.parseDecimal(_stock.text),
                lowStockThreshold: Fmt.parseDecimal(_threshold.text),
              ),
            );
          },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
