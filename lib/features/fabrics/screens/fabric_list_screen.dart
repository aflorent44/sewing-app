import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:mon_app_couture/features/fabrics/dialogs/fabric_form_dialog.dart';
import 'package:mon_app_couture/services/api/fabric_service.dart';
import 'package:mon_app_couture/shared/filters.dart/keyword_filter.dart';
import 'package:mon_app_couture/shared/filters.dart/quantity_filter.dart';
import 'package:mon_app_couture/shared/filters.dart/season_filter.dart';
import 'package:mon_app_couture/shared/filters.dart/colour_filter.dart';

class FabricsScreen extends StatefulWidget {
  const FabricsScreen({super.key});

  @override
  State<FabricsScreen> createState() => _FabricsScreenState();
}

class _FabricsScreenState extends State<FabricsScreen> {
  List<Fabric> allFabrics = [];
  List<Fabric> filteredFabrics = [];
  bool _isLoading = false;
  bool _hasError = false;
  Set<Colour> selectedColours = {};
  Set<Season> selectedSeasons = {};
  String searchTerm = '';
  double minRequiredQuantity = 0.0;
  
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
      refreshFabrics();
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des tissus")),
      body: Column(
        children: [
          KeywordFilter(typedString: searchTerm, onChanged: _onKeywordChanged),
          SeasonFilter(
            selectedSeasons: selectedSeasons,
            onSelectionChanged: _onSeasonsChanged,
          ),
          ColourFilter(
            selectedColours: selectedColours,
            onSelectionChanged: _onColoursChanged,
          ),
          QuantityFilter(
            mininumQuantity: minRequiredQuantity,
            onChanged: _onQuantityChanged,
          ),
          Divider(),
          Expanded(child: _buildBody()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () => _openFabricForm(context, null),
              icon: Icon(Icons.add),
              label: Text("Ajouter un tissu"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (_hasError) {
      return Center(child: Text('Une erreur est survenue 😢'));
    } else if (filteredFabrics.isEmpty) {
      return Center(child: Text('Aucun tissu à afficher.'));
    } else {
      return ListView.builder(
        itemCount: filteredFabrics.length,
        itemBuilder: (context, index) {
          final fabric = filteredFabrics[index];
          return ListTile(
            title: Text(fabric.name),
            onTap: () => _openFabricForm(context, fabric),
          );
        },
      );
    }
  }

  void _openFabricForm(BuildContext context, Fabric? fabric) async {
    final result = await showDialog(
      context: context,
      builder: (context) => FabricFormDialog(fabric: fabric),
    );

    if (result == true) {
      await refreshFabrics();
    }
  }

  Future<void> refreshFabrics() async {
    final fabrics = await fetchFabrics();
    setState(() {
      allFabrics = fabrics;
      _applyFilters();
      _isLoading = false;
    });
  }

  void _onKeywordChanged(String newKeyword) async {
    setState(() {
      searchTerm = newKeyword;
      _isLoading = true;
    });

    try {
      final results = await fetchFabricsByKeyword(newKeyword);
      setState(() {
        allFabrics = results;
        _applyFilters(); 
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void _onColoursChanged(Set<Colour> newSelectedColours) {
    setState(() {
      selectedColours = newSelectedColours;
      _applyFilters(); 
    });
  }

  void _onSeasonsChanged(Set<Season> newSelectedSeasons) {
    setState(() {
      selectedSeasons = newSelectedSeasons;
      _applyFilters(); 
    });
  }

  void _onQuantityChanged(double newMinQuantity) {
    setState(() {
      minRequiredQuantity = newMinQuantity;
      _applyFilters(); 
    });
  }

  void _applyFilters() {
    filteredFabrics = allFabrics.where((fabric) {
      final matchesColour = selectedColours.isEmpty
          ? true
          : fabric.colours!.any((c) => selectedColours.contains(c));

      final matchesSeason = selectedSeasons.isEmpty
          ? true
          : fabric.seasons!.any((s) => selectedSeasons.contains(s));

      final matchesQuantity = minRequiredQuantity == 0.0
          ? true
          : fabric.quantity! >= minRequiredQuantity;

      return matchesColour && matchesSeason && matchesQuantity;
    }).toList();
  }
}
