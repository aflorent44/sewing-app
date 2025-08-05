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
  late String _displayValue;

  @override
  void initState() {
    super.initState();
    _initializeSelection();
  }

  @override
  void didUpdateWidget(covariant CustomAutocompleteField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Seulement si les options ont changé (chargement initial des données)
    // ou si la sélection externe a changé
    if (widget.options != oldWidget.options ||
        widget.selected != oldWidget.selected) {
      _initializeSelection();
    }
  }

  void _initializeSelection() {
    _currentSelection = widget.selected;
    _displayValue = _currentSelection != null
        ? widget.itemLabelBuilder(_currentSelection!)
        : '';

    print(
      "${widget.label} - Sélection reçue: ${widget.selected != null ? widget.itemLabelBuilder(widget.selected!) : 'null'}",
    );
    print(
      "${widget.label} - Valeur d'affichage: ${_displayValue.isNotEmpty ? _displayValue : 'vide'}",
    );
  }

  void _clearSelection() {
    setState(() {
      _currentSelection = null;
      _displayValue = '';
    });
    widget.onChanged(null);
  }

  void _onSelected(T option) {
    setState(() {
      _currentSelection = option;
      _displayValue = widget.itemLabelBuilder(option);
      print('Option choisie: ${widget.itemLabelBuilder(option)}');
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
    return Column(
      children: [
        const SizedBox(height: 16),
        Autocomplete<T>(
          initialValue: TextEditingValue(text: _displayValue),
          displayStringForOption: widget.itemLabelBuilder,
          optionsBuilder: (TextEditingValue textEditingValue) {
            return _filterOptions(textEditingValue.text);
          },
          onSelected: _onSelected,
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
                // Synchroniser le contrôleur avec notre valeur d'affichage
                // mais seulement si nécessaire pour éviter les boucles
                if (textEditingController.text != _displayValue) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted &&
                        textEditingController.text != _displayValue) {
                      textEditingController.text = _displayValue;
                      textEditingController.selection =
                          TextSelection.fromPosition(
                            TextPosition(offset: _displayValue.length),
                          );
                    }
                  });
                }

                return TextFormField(
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
                );
              },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                    minWidth: 200,
                  ),
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
                              trailing: isSelected
                                  ? const Icon(Icons.check)
                                  : null,
                            );
                          },
                        ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
