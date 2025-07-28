import 'package:flutter/material.dart';

class CustomAutocompleteField<T extends Object> extends StatelessWidget {
  final String label;
  final List<T> options;
  final T? selected;
  final void Function(T) onChanged;
  final String Function(T) itemLabelBuilder;

  const CustomAutocompleteField({
    super.key,
    required this.label,
    required this.options,
    this.selected,
    required this.onChanged,
    required this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<T>(
      displayStringForOption: itemLabelBuilder,
      initialValue: selected != null
          ? TextEditingValue(text: itemLabelBuilder(selected!))
          : null,
      optionsBuilder: (TextEditingValue textEditingValue) {
        return options
            .where(
              (option) => itemLabelBuilder(
                option,
              ).toLowerCase().contains(textEditingValue.text.toLowerCase()),
            )
            .toList();
      },
      onSelected: onChanged,
      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(labelText: label),
              onFieldSubmitted: (_) => onFieldSubmitted(),
            );
          },
      optionsViewBuilder:
          (
            BuildContext context,
            AutocompleteOnSelected<T> onSelected,
            Iterable<T> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final T option = options.elementAt(index);
                    return ListTile(
                      title: Text(itemLabelBuilder(option)),
                      onTap: () => onSelected(option),
                    );
                  },
                ),
              ),
            );
          },
    );
  }
}
