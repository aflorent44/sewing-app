import 'package:flutter/material.dart';

class CustomAutocompleteField<T extends Object> extends StatefulWidget {
  final String label;
  final List<T> options;
  final List<T> selected;
  final String Function(T) itemLabelBuilder;
  final void Function(List<T>) onChanged;
  final void Function(List<String>)? onToCreateChanged;

  const CustomAutocompleteField({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.itemLabelBuilder,
    required this.onChanged,
    this.onToCreateChanged,
  });

  @override
  State<CustomAutocompleteField<T>> createState() =>
      _CustomAutocompleteFieldState<T>();
}

class _CustomAutocompleteFieldState<T extends Object>
    extends State<CustomAutocompleteField<T>> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final VoidCallback _textListener;
  String _currentInput = '';
  List<String> _toCreate = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    _textListener = () {
      if (context.mounted) {
        setState(() {
          _currentInput = _controller.text;
        });
      }
    };

    _controller.addListener(_textListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_textListener);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 8),
        RawAutocomplete<T>(
          textEditingController: _controller,
          focusNode: _focusNode,
          optionsBuilder: (TextEditingValue textEditingValue) {
            _currentInput = textEditingValue.text;

            if (textEditingValue.text.isEmpty) return Iterable<T>.empty();
            return widget.options.where((T option) {
              return widget
                  .itemLabelBuilder(option)
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          displayStringForOption: widget.itemLabelBuilder,
          onSelected: (T selectedItem) {
            _controller.clear();
            if (!widget.selected.contains(selectedItem)) {
              final updated = [...widget.selected, selectedItem];
              widget.onChanged(updated);
            }
          },
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                border: const OutlineInputBorder(),
                suffixIcon: _controller.text.length >= 3
                    ? IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          final input = _controller.text.trim();
                          if (input.isNotEmpty && !_toCreate.contains(input)) {
                            setState(() {
                              _toCreate.add(input);
                              widget.onToCreateChanged?.call(_toCreate);
                              _controller.clear();
                              _currentInput = '';
                            });
                          }
                        },
                      )
                    : null,
              ),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            final lowerInput = _currentInput.toLowerCase();
            final matches = widget.options
                .where(
                  (option) => widget
                      .itemLabelBuilder(option)
                      .toLowerCase()
                      .contains(lowerInput),
                )
                .toList();

            final hasExactMatch = matches.any(
              (option) =>
                  widget.itemLabelBuilder(option).toLowerCase() == lowerInput,
            );

            if (_currentInput.length >= 3 && !hasExactMatch) {
              // On ajoute une entrée "Créer"
              return ListTile(
                leading: const Icon(Icons.add),
                title: Text("Créer \"$_currentInput\""),
                onTap: () {
                  if (!_toCreate.contains(_currentInput)) {
                    _toCreate.add(_currentInput);
                    widget.onToCreateChanged?.call(_toCreate);
                  }
                  _controller.clear();
                  setState(() {
                    _currentInput = '';
                  });
                },
              );
            }

            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: options.map((T option) {
                    return ListTile(
                      title: Text(widget.itemLabelBuilder(option)),
                      onTap: () => onSelected(option),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 2,
          runSpacing: 2,
          children: [
            ...widget.selected.map(
              (item) => Chip(
                label: Text(widget.itemLabelBuilder(item)),
                onDeleted: () {
                  final updated = [...widget.selected]..remove(item);
                  widget.onChanged(updated);
                },
              ),
            ),
            ..._toCreate.map(
              (name) => Chip(
                label: Text(name),
                onDeleted: () {
                  setState(() {
                    _toCreate.remove(name);
                    widget.onToCreateChanged?.call(_toCreate);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
