import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:mon_app_couture/features/fabrics/dialogs/fabric_form_dialog.dart';
import 'package:mon_app_couture/services/api/fabric_service.dart';

class FabricsScreen extends StatefulWidget {
  const FabricsScreen({super.key});

  @override
  State<FabricsScreen> createState() => _FabricsScreenState();
}

class _FabricsScreenState extends State<FabricsScreen> {
  late Future<List<Fabric>> _futureFabrics;

  @override
  void initState() {
    super.initState();
    _futureFabrics = fetchFabrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des tissus")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Fabric>>(
              future: _futureFabrics,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur de chargement 😢'));
                } else if (snapshot.hasData) {
                  final fabrics = snapshot.data!;

                  // 🔍 Petit log pour confirmer ce qui est affiché :
                  for (final fabric in fabrics) {
                    print('🧵 Affiché : ${fabric.name} (${fabric.id})');
                  }

                  if (fabrics.isEmpty) {
                    return Center(child: Text('Aucun tissu à afficher.'));
                  }

                  return ListView.builder(
                    itemCount: fabrics.length,
                    itemBuilder: (context, index) {
                      final fabric = fabrics[index];
                      return ListTile(
                        title: Text(fabric.name),
                        onTap: () => _showFabricDetails(context, fabric),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('Aucun tissu trouvé.'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (context) => FabricFormDialog(fabric: null),
                );

                if (result == true) {
                  setState(() {
                    _futureFabrics = fetchFabrics(); // Recharge les données
                  });
                }
              },
              icon: Icon(Icons.add),
              label: Text("Ajouter un tissu"),
            ),
          ),
        ],
      ),
    );
  }

  void _showFabricDetails(BuildContext context, Fabric fabric) async {
    final result = await showDialog(
      context: context,
      builder: (context) => FabricFormDialog(fabric: fabric),
    );

    if (result == true) {
      setState(() {
        _futureFabrics = fetchFabrics();
      });
    }
  }
}
