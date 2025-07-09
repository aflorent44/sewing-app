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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Pour que la colonne ne prenne pas tout l’espace vertical
          children: [
            Text("Liste des tissus"),
            SizedBox(height: 20),
            FutureBuilder<List<Fabric>>(
              future: _futureFabrics,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final fabrics = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: fabrics.length,
                    itemBuilder: (context, index) {
                      final fabric = fabrics[index];
                      return ListTile(
                        title: Text(fabric.name),
                        onTap: () => _showFabricDetails(context, fabric),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Erreur lors du chargement des tissus');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (context) => FabricFormDialog(fabric: null),
                );

                if (result == true) {
                  setState(() {
                    _futureFabrics = fetchFabrics(); // on recharge la liste !
                  });
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text("Ajouter un tissu"),
                ],
              ),
            ),
          ],
        ),
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
