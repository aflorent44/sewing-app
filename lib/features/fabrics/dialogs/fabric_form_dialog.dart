import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/brand.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_app_couture/models/fabric_type.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/material_model.dart';
import 'package:mon_app_couture/services/api/fabric_service.dart';
import 'package:mon_app_couture/services/api/material_service.dart';
import 'package:mon_app_couture/shared/widgets/custom_autocomplete_field.dart';
import 'package:mon_app_couture/shared/widgets/custom_chip_field.dart';
import 'package:mon_app_couture/shared/widgets/custom_numeric_field.dart';
import 'package:mon_app_couture/shared/widgets/custom_text_field.dart';

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
  late List<MaterialModel> _availableMaterials = [];
  late List<MaterialModel> _selectedMaterials = [];
  late List<String> _toCreateMaterials = [];
  late String _weave;
  late Brand _brand;
  late String _description;
  late List<Season> _selectedSeasons;
  late List<Colour> _selectedColours;
  late String _width;
  late String _extensiveness;
  late String _price;
  late String _link;
  late String _notes;

  @override
  void initState() {
    super.initState();
    _loadMaterials();
    _name = widget.fabric?.name ?? '';
    _description = widget.fabric?.description ?? '';
    _width = widget.fabric?.width.toString() ?? '';
    _extensiveness = widget.fabric?.extensiveness.toString() ?? '';
    _price = widget.fabric?.price.toString() ?? '';
    _quantity = widget.fabric?.quantity.toString() ?? '';
    _selectedSeasons = widget.fabric?.seasons ?? [];
    _selectedColours = widget.fabric?.colours ?? [];
    _notes = widget.fabric?.notes ?? '';
  }

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

  Future<void> _loadMaterials() async {
    try {
      final materials = await fetchMaterials();
      setState(() {
        _availableMaterials = materials;
        if (widget.fabric?.materials != null) {
          _selectedMaterials = widget.fabric!.materials!;
        }
      });
    } catch (e) {
      print("Erreur chargement matières : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.fabric != null;
    final buttonText = !isEditing ? 'Ajouter' : 'Modifier';

    return Dialog(
      child: Container(
        width: 600, // Personnalise la taille ici
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                !isEditing ? 'Ajouter un tissu' : 'Modifier le tissu',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Nom du tissu',
                      initialValue: _name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir le nom du tissu';
                        }
                        return null;
                      },
                      onSaved: (value) => _name = value!,
                    ),
                    CustomTextField(
                      label: 'Description',
                      initialValue: _description,
                      onSaved: (value) => _description = value!,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: CustomNumericField(
                            label: 'Quantité (en m)',
                            initialValue: _quantity,
                            onSaved: (value) => _quantity = value!,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: CustomNumericField(
                            label: 'Laize (en cm)',
                            initialValue: _width,
                            onSaved: (value) => _width = value!,
                          ),
                        ),
                      ],
                    ),
                    CustomChipField<Season>(
                      label: 'Saisons',
                      values: Season.values,
                      selected: _selectedSeasons,
                      onChanged: (seasons) {
                        setState(() {
                          _selectedSeasons = seasons;
                        });
                      },
                      labelBuilder: (s) =>
                          s.label, // si tu as un champ `label` dans Season
                    ),
                    CustomChipField<Colour>(
                      label: 'Couleurs',
                      values: Colour.values,
                      selected: _selectedColours,
                      onChanged: (colours) {
                        setState(() {
                          _selectedColours = colours;
                        });
                      },
                      labelBuilder: (s) =>
                          s.label, // si tu as un champ `label` dans Season
                    ),
                    CustomAutocompleteField<MaterialModel>(
                      label: 'Matières',
                      options: _availableMaterials,
                      selected: _selectedMaterials,
                      itemLabelBuilder: (material) => material.name,
                      onChanged: (updatedList) {
                        setState(() {
                          _selectedMaterials = updatedList;
                        });
                      },
                      onToCreateChanged: (newToCreate) {
                        setState(() {
                          _toCreateMaterials = newToCreate;
                        });
                      },
                    ),
                    CustomTextField(
                      label: 'Notes',
                      initialValue: _notes,
                      onSaved: (value) => _notes = value!,
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
                                await saveFabric(
                                  _name,
                                  _description,
                                  _quantity,
                                  _width,
                                  _selectedSeasons,
                                  _selectedColours,
                                  _selectedMaterials,
                                  _toCreateMaterials,
                                  _notes,
                                );
                              } else {
                                await updateFabric(
                                  widget.fabric!.id,
                                  _name,
                                  _description,
                                  _quantity,
                                  _width,
                                  _selectedSeasons,
                                  _selectedColours,
                                  _selectedMaterials,
                                  _toCreateMaterials,
                                  _notes,
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
      ),
    );
  }
}
