import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/patterns/dialogs/pattern_form_dialog.dart';
import 'package:mon_app_couture/features/patterns/widgets/patterns_body.dart';
import 'package:mon_app_couture/models/pattern_model.dart';
import 'package:mon_app_couture/services/api/pattern_service.dart';

class PatternsScreen extends StatefulWidget {
  const PatternsScreen({super.key});

  @override
  State<PatternsScreen> createState() => _PatternsScreenState();
}

class _PatternsScreenState extends State<PatternsScreen> {
  bool _isLoading = false;
  bool _hasError = false;
  List<PatternModel> displayedPatterns = [];
  
  @override
  void initState() {
    super.initState();
    loadPatterns();
  }

  Future<void> loadPatterns() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final patterns = await fetchPatterns();
      displayedPatterns = patterns;
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

  void _openPatternForm(PatternModel? pattern) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => PatternFormDialog(pattern: pattern),
    );
    if (result == true) {
      await loadPatterns();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patrons")),
      body: Column(
        children: [
          Expanded(
            child: PatternsBody(
              patterns: displayedPatterns,
              isLoading: _isLoading,
              hasError: _hasError,
              openPatternForm: _openPatternForm,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openPatternForm(null),
        tooltip: 'Ajouter un tissu',
        child: const Icon(Icons.add),
      ),
    );
  }
}
