import 'package:flutter/material.dart';

class CustomAutocompleteField<T extends Object> extends StatefulWidget {
  final String label;
  final List<T> options;
  final T? selected;
  final void Function(T?) onChanged;
  final String Function(T) itemLabelBuilder;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomAutocompleteField({
    super.key,
    required this.label,
    required this.options,
    this.selected,
    required this.onChanged,
    required this.itemLabelBuilder,
    this.validator,
    this.enabled = true,
  });

  @override
  State<CustomAutocompleteField<T>> createState() =>
      _CustomAutocompleteFieldState<T>();
}

class _CustomAutocompleteFieldState<T extends Object>
    extends State<CustomAutocompleteField<T>> {
  T? _currentSelection;
  late String _initialValue;

  @override
  void initState() {
    super.initState();
    _currentSelection = widget.selected;
    _initialValue = _currentSelection != null
        ? widget.itemLabelBuilder(_currentSelection!)
        : '';
  }

  @override
  void didUpdateWidget(covariant CustomAutocompleteField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Mise à jour si la sélection externe change
    if (widget.selected != _currentSelection) {
      _currentSelection = widget.selected;
      _initialValue = _currentSelection != null
          ? widget.itemLabelBuilder(_currentSelection!)
          : '';
    }

    // Vérifier si la sélection actuelle existe toujours dans les nouvelles options
    if (widget.options != oldWidget.options && _currentSelection != null) {
      final stillExists = widget.options.any(
        (option) =>
            widget.itemLabelBuilder(option) ==
            widget.itemLabelBuilder(_currentSelection!),
      );

      if (!stillExists) {
        _currentSelection = null;
        _initialValue = '';
        // Différer l'appel de onChanged pour éviter setState pendant build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onChanged(null);
        });
      }
    }
  }

  void _clearSelection() {
    setState(() {
      _currentSelection = null;
      _initialValue = '';
    });
    widget.onChanged(null);
  }

  void _onSelected(T option) {
    setState(() {
      _currentSelection = option;
      _initialValue = widget.itemLabelBuilder(option);
    });
    widget.onChanged(option);
  }

  List<T> _filterOptions(String query) {
    if (query.isEmpty) return widget.options;

    final lowerQuery = query.toLowerCase().trim();
    return widget.options.where((option) {
      final label = widget.itemLabelBuilder(option).toLowerCase();
      return label.contains(lowerQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      initialValue: TextEditingValue(text: _initialValue),
      displayStringForOption: widget.itemLabelBuilder,
      optionsBuilder: (TextEditingValue textEditingValue) {
        return _filterOptions(textEditingValue.text);
      },
      onSelected: _onSelected,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
            // Synchroniser UNIQUEMENT si nécessaire et pas pendant le build
            if (textEditingController.text != _initialValue) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (textEditingController.text != _initialValue) {
                  textEditingController.text = _initialValue;
                }
              });
            }
            return Column(
              children: [
                SizedBox(height: 16),
                TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  enabled: widget.enabled,
                  validator: widget.validator,
                  decoration: InputDecoration(
                    labelText: widget.label,
                    border: const OutlineInputBorder(),
                    suffixIcon: _currentSelection != null && widget.enabled
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _clearSelection,
                            tooltip: 'Effacer la sélection',
                          )
                        : const Icon(Icons.arrow_drop_down),
                  ),
                  onChanged: (value) {
                    // Si le texte ne correspond plus à la sélection actuelle, effacer la sélection
                    if (_currentSelection != null &&
                        value != widget.itemLabelBuilder(_currentSelection!)) {
                      setState(() {
                        _currentSelection = null;
                      });
                      widget.onChanged(null);
                    }
                  },
                  onFieldSubmitted: (_) => onFieldSubmitted(),
                ),
              ],
            );
          },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, minWidth: 200),
              child: options.isEmpty
                  ? Container(
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        'Aucun résultat trouvé',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);
                        final isSelected =
                            _currentSelection != null &&
                            widget.itemLabelBuilder(option) ==
                                widget.itemLabelBuilder(_currentSelection!);

                        return ListTile(
                          dense: true,
                          title: Text(
                            widget.itemLabelBuilder(option),
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : null,
                            ),
                          ),
                          selected: isSelected,
                          onTap: () => onSelected(option),
                          trailing: isSelected ? const Icon(Icons.check) : null,
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
