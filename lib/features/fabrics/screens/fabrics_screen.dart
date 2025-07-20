import 'package:flutter/material.dart';
import 'package:mon_app_couture/features/fabrics/controllers/fabrics_controller.dart';
import 'package:mon_app_couture/features/fabrics/widgets/fabrics_body.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/fabric_filters_bar.dart';
import 'package:mon_app_couture/features/fabrics/widgets/sorting/fabric_sorting.dart';
import 'package:mon_app_couture/features/fabrics/widgets/sorting/fabric_sorting_bar.dart';
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

  bool _showFilters = false;
  bool _showSorting = false;
  bool _isLoading = false;
  bool _hasError = false;

  // Notre unique objet qui contient tous les filtres
  FabricFilters filters = FabricFilters();

  // Notre unique objet qui contient tous les critères de tri
  FabricSorting sorting = FabricSorting();

  // Liste des tissus à afficher, filtrée et triée
  List<Fabric> displayedFabrics = [];

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
      // Appliquer filtres et tri sur la liste chargée
      displayedFabrics = controller.getFilteredAndSortedFabrics(
        filters: filters,
        sorting: sorting,
      );
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

  Future<void> _onSortingChanged(FabricSorting newSorting) async {
    setState(() {
      sorting = newSorting;
      _isLoading = true;
      _hasError = false;
    });

    try {
      displayedFabrics = controller.getFilteredAndSortedFabrics(
        filters: filters,
        sorting: sorting,
      );
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
      } else {
        final all = await fetchFabrics();
        controller.allFabrics = all;
      }
      displayedFabrics = controller.getFilteredAndSortedFabrics(
        filters: filters,
        sorting: sorting,
      );
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
    final result = await showDialog<bool>(
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
      appBar: AppBar(
        title: const Text("Liste des tissus"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            tooltip: _showFilters
                ? 'Masquer les filtres'
                : 'Afficher les filtres',
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            tooltip: _showSorting
                ? 'Masquer les critères de tri'
                : 'Afficher les critères de tri',
            onPressed: () {
              setState(() {
                _showSorting = !_showSorting;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showFilters)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FabricFiltersBar(
                filters: filters,
                onFiltersChanged: _onFiltersChanged,
              ),
            ),
          if (_showSorting)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FabricSortingBar(
                sorting: sorting,
                onSortingChanged: _onSortingChanged,
              ),
            ),
          Expanded(
            child: FabricsBody(
              filters: filters,
              onFiltersChanged: _onFiltersChanged,
              fabrics: displayedFabrics,
              isLoading: _isLoading,
              hasError: _hasError,
              openFabricForm: _openFabricForm,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFabricForm(null),
        tooltip: 'Ajouter un tissu',
        child: const Icon(Icons.add),
      ),
    );
  }
}
