import 'package:material_ui/material_ui.dart';

/// Freitextfeld mit Vorschlägen aus früheren Einträgen.
class SuggestField extends StatefulWidget {
  const SuggestField({
    super.key,
    required this.controller,
    required this.label,
    required this.suggestions,
    this.textCapitalization = TextCapitalization.sentences,
  });

  final TextEditingController controller;
  final String label;
  final List<String> suggestions;
  final TextCapitalization textCapitalization;

  @override
  State<SuggestField> createState() => _SuggestFieldState();
}

class _SuggestFieldState extends State<SuggestField> {
  final _focus = FocusNode();

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      textEditingController: widget.controller,
      focusNode: _focus,
      optionsBuilder: (value) {
        final q = value.text.trim().toLowerCase();
        return widget.suggestions
            .where(
              (s) =>
                  s.toLowerCase() != q &&
                  (q.isEmpty || s.toLowerCase().contains(q)),
            )
            .take(8);
      },
      fieldViewBuilder: (context, controller, focusNode, onSubmitted) =>
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            textCapitalization: widget.textCapitalization,
            decoration: InputDecoration(labelText: widget.label),
            onFieldSubmitted: (_) => onSubmitted(),
          ),
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 240, maxWidth: 360),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                for (final o in options)
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.history, size: 18),
                    title: Text(o),
                    onTap: () => onSelected(o),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
