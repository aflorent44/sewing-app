import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/fabrics/controllers/fabrics_controller.dart';
import 'package:mon_app_couture/features/fabrics/widgets/fabrics_body.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:mon_app_couture/features/fabrics/dialogs/fabric_form_dialog.dart';
import 'package:mon_app_couture/services/api/fabric_service.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/fabric_filters.dart';

class FabricsScreen extends StatefulWidget {
  const FabricsScreen({super.key});

  @override
  State<FabricsScreen> createState() => _FabricsScreenState();
}

class _FabricsScreenState extends State<FabricsScreen> {
  final FabricsController controller = FabricsController();

  List<Fabric> filteredFabrics = [];
  bool _isLoading = false;
  bool _hasError = false;

  // Notre unique objet qui contient tous les filtres
  FabricFilters filters = FabricFilters();

  @override
  void initState() {
    super.initState();
    loadFabrics();
  }

  Future<void> loadFabrics() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final fabrics = await fetchFabrics();
      controller.allFabrics = fabrics;
      filteredFabrics = controller.applyFilters(filters);
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

  Future<void> _onFiltersChanged(FabricFilters newFilters) async {
    setState(() {
      filters = newFilters;
      _isLoading = true;
      _hasError = false;
    });

    try {
      // Si la recherche par mot clé est active, on peut recharger depuis le backend
      if (filters.searchTerm.isNotEmpty) {
        final results = await fetchFabricsByKeyword(filters.searchTerm);
        controller.allFabrics = results;
      }
      filteredFabrics = controller.applyFilters(filters);
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

  void _openFabricForm(Fabric? fabric) async {
    final result = await showDialog(
      context: context,
      builder: (context) => FabricFormDialog(fabric: fabric),
    );
    if (result == true) {
      await loadFabrics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des tissus")),
      body: FabricsBody(
        filters: filters,
        onFiltersChanged: _onFiltersChanged,
        fabrics: filteredFabrics,
        isLoading: _isLoading,
        hasError: _hasError,
        openFabricForm: _openFabricForm,
      ),
    );
  }
}
