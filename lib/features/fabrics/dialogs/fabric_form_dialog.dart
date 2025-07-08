import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mon_app_couture/models/colour.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_app_couture/models/fabric_type.dart';
import 'package:mon_app_couture/models/season.dart';

class FabricFormDialog extends StatefulWidget {
  final Fabric? fabric;

  const FabricFormDialog({super.key, this.fabric});

  @override
  State<FabricFormDialog> createState() => _FabricFormDialogState();
}

class _FabricFormDialogState extends State<FabricFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late FabricType _type;
  late String _quantity;
  late List<Material> _materials;
  late String _weave;
  late String _brand;
  late String _description;
  late List<Season> _seasons;
  late List<Colour> _colours;
  late String _width;
  late String _extensiveness;
  late String _price;
  late String _link;
  late String _notes;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _name = widget.fabric?.name ?? '';
    _quantity = widget.fabric?.quantity.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.fabric != null;
    final buttonText = !isEditing ? 'Ajouter' : 'Modifier';

    return Dialog(
      child: Container(
        width: 400, // Personnalise la taille ici
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              !isEditing ? 'Ajouter un tissu' : 'Modifier le tissu',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _name,
                    decoration: const InputDecoration(
                      labelText: 'Nom du tissu',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir le nom du tissu';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                  TextFormField(
                    initialValue: _quantity,
                    decoration: const InputDecoration(
                      labelText: 'Quantité (mètres)',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      final parsed = double.tryParse(value ?? '');
                      if (parsed == null || parsed <= 0) {
                        return 'Entrez une quantité valide';
                      }
                      return null;
                    },
                    onSaved: (value) => _quantity = value!,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      if (_image != null)
                        Image.file(
                          _image!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      else
                        const Text("Aucune image sélectionnée"),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _takePhoto,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text("Prendre une photo"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            if (!isEditing) {
                              await saveFabric(_name, _quantity);
                            } else {
                              await updateFabric(
                                widget.fabric!.id,
                                _name,
                                _quantity
                              );
                            }

                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Tissu ${!isEditing ? 'ajouté' : 'modifié'} avec succès',
                                ),
                              ),
                            );

                            Navigator.pop(context, true);
                          }
                        },
                        child: Text(buttonText),
                      ),

                      // 👇 Ce bouton ne s’affiche QUE si on édite
                      if (isEditing)
                        ElevatedButton(
                          child: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Confirmation"),
                                content: Text(
                                  "Voulez-vous vraiment supprimer ce tissu ?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text("Annuler"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text("Supprimer"),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await deleteFabric(widget.fabric!.id);
                              if (!context.mounted) return;
                              Navigator.pop(context, true);
                            }
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> saveFabric(String name, String quantity) async {
  final url = Uri.parse('http://192.168.1.21:3000/fabric');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'quantity': double.tryParse(quantity) ?? 0,
    }),
  );

  if (response.statusCode == 201) {
    print('Tissu ajouté avec succès');
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
  }
}

Future<void> updateFabric(
  String id,
  String name,
  String quantity,
) async {
  final url = Uri.parse('http://192.168.1.21:3000/fabric/$id');

  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'quantity': double.tryParse(quantity) ?? 0,
    }),
  );

  if (response.statusCode == 200) {
    print('Tissu mis à jour avec succès');
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
  }
}

Future<void> deleteFabric(String id) async {
  final url = Uri.parse('http://192.168.1.21:3000/fabric/$id');

  final response = await http.delete(url);

  if (response.statusCode == 200) {
    print('Tissu supprimé avec succès');
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
  }
}
