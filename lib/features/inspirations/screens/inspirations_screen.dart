import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/inspirations/dialogs/inspiration_form_dialog.dart';
import 'package:mon_app_couture/features/inspirations/widgets/inspiration_body.dart';
import 'package:mon_app_couture/models/inspiration.dart';
import 'package:mon_app_couture/services/api/inspiration_service.dart';

class InspirationsScreen extends StatefulWidget {
  const InspirationsScreen({super.key});

  @override
  State<InspirationsScreen> createState() => _InspirationsScreenState();
}

class _InspirationsScreenState extends State<InspirationsScreen> {
  bool _isLoading = false;
  bool _hasError = false;
  List<Inspiration> displayedElements = [];

  @override
  void initState() {
    super.initState();
    loadElements();
  }

  Future<void> loadElements() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final elements = await fetchInspirations();
      displayedElements = elements;
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void _openForm(Inspiration? element) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => InspirationFormDialog(inspiration: element),
    );
    if (result == true) {
      await loadElements();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inspirations")),
      body: Column(
        children: [
          Expanded(
            child: InspirationsBody(
              inspirations: displayedElements,
              isLoading: _isLoading,
              hasError: _hasError,
              openForm: _openForm,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(null),
        tooltip: 'Ajouter une inspiration',
        child: const Icon(Icons.add),
      ),
    );
  }
}
