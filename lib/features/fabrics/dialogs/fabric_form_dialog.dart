import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:mon_app_couture/models/material_model.dart';
import 'package:mon_app_couture/services/api/fabric_service.dart';
import 'package:mon_app_couture/services/api/material_service.dart';
import 'package:mon_app_couture/shared/custom_fields.dart/custom_autocomplete_field.dart';
import 'package:mon_app_couture/shared/custom_fields.dart/custom_chip_field.dart';
import 'package:mon_app_couture/shared/custom_fields.dart/custom_numeric_field.dart';
import 'package:mon_app_couture/shared/custom_fields.dart/custom_text_field.dart';

class FabricFormData {
  String? id;
  String name;
  String description;
  double quantity;
  int width;
  List<Season> seasons;
  List<Colour> colours;
  List<MaterialModel> materials;
  String notes;

  FabricFormData({
    this.id,
    this.name = '',
    this.description = '',
    this.quantity = 0.0,
    this.width = 0,
    List<Season>? seasons,
    List<Colour>? colours,
    List<MaterialModel>? materials,
    this.notes = '',
  }) : seasons = seasons ?? [],
       colours = colours ?? [],
       materials = materials ?? [];

  // Crée un Fabric à partir des données du formulaire
  Fabric toFabric() {
    return Fabric(
      id: id,
      name: name,
      description: description,
      quantity: quantity,
      width: width,
      seasons: seasons,
      colours: colours,
      materials: materials,
      notes: notes,
    );
  }
}

class FabricFormDialog extends StatefulWidget {
  final Fabric? fabric;

  const FabricFormDialog({Key? key, this.fabric}) : super(key: key);

  @override
  State<FabricFormDialog> createState() => _FabricFormDialogState();
}

class _FabricFormDialogState extends State<FabricFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late FabricFormData _formData;
  List<MaterialModel> _availableMaterials = [];
  List<String> _toCreateMaterials = [];

  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    // Initialise _formData selon qu'on édite ou crée un nouveau tissu
    final f = widget.fabric;
    _formData = FabricFormData(
      id: f?.id,
      name: f?.name ?? '',
      description: f?.description ?? '',
      quantity: f?.quantity ?? 0.0,
      width: f?.width ?? 0,
      seasons: f?.seasons ?? [],
      colours: f?.colours ?? [],
      materials: f?.materials ?? [],
      notes: f?.notes ?? '',
    );

    _loadMaterials();
  }

  Future<void> _loadMaterials() async {
    try {
      final materials = await fetchMaterials();
      setState(() {
        _availableMaterials = materials;
      });
    } catch (e) {
      print("Erreur chargement matières : $e");
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final fabric = _formData.toFabric();

    saveFabricOffline(fabric); // Sauvegarde locale immédiate

    final isEditing = widget.fabric != null;

    try {
      if (!isEditing) {
        await saveFabric(fabric, _toCreateMaterials);
      } else {
        updateFabricOffline(fabric);
        await updateFabric(fabric.id!, fabric, _toCreateMaterials);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tissu ${isEditing ? 'modifié' : 'ajouté'} avec succès',
          ),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      print('Pas de connexion, enregistrement uniquement local : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Enregistrement local effectué, synchronisation en attente',
          ),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.fabric != null;
    final buttonText = isEditing ? 'Modifier' : 'Ajouter';

    return Dialog(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEditing ? 'Modifier le tissu' : 'Ajouter un tissu',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Nom du tissu',
                  initialValue: _formData.name,
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Veuillez saisir le nom du tissu'
                      : null,
                  onSaved: (v) => _formData.name = v ?? '',
                ),
                CustomTextField(
                  label: 'Description',
                  initialValue: _formData.description,
                  onSaved: (v) => _formData.description = v ?? '',
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomNumericField(
                        label: 'Quantité (en m)',
                        initialValue: _formData.quantity.toString(),
                        onSaved: (v) => _formData.quantity =
                            double.tryParse(v ?? '') ?? 0.0,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomNumericField(
                        label: 'Laize (en cm)',
                        initialValue: _formData.width.toString(),
                        onSaved: (v) =>
                            _formData.width = int.tryParse(v ?? '') ?? 0,
                      ),
                    ),
                  ],
                ),
                CustomChipField<Season>(
                  label: 'Saisons',
                  values: Season.values,
                  selected: _formData.seasons,
                  onChanged: (val) => setState(() => _formData.seasons = val),
                  labelBuilder: (s) => s.label,
                ),
                CustomChipField<Colour>(
                  label: 'Couleurs',
                  values: Colour.values,
                  selected: _formData.colours,
                  onChanged: (val) => setState(() => _formData.colours = val),
                  labelBuilder: (c) => c.label,
                ),
                CustomAutocompleteField<MaterialModel>(
                  label: 'Matières',
                  options: _availableMaterials,
                  selected: _formData.materials,
                  itemLabelBuilder: (m) => m.name,
                  onChanged: (val) => setState(() => _formData.materials = val),
                  onToCreateChanged: (val) =>
                      setState(() => _toCreateMaterials = val),
                ),
                CustomTextField(
                  label: 'Notes',
                  initialValue: _formData.notes,
                  onSaved: (v) => _formData.notes = v ?? '',
                ),
                const SizedBox(height: 16),
                if (_image != null)
                  Image.file(
                    _image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                else
                  const Text('Aucune image sélectionnée'),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Prendre une photo'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _onSubmit,
                      child: Text(buttonText),
                    ),
                    if (isEditing)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text(
                                'Voulez-vous vraiment supprimer ce tissu ?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Annuler'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text('Supprimer'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            await deleteFabric(widget.fabric!.id!);
                            if (!context.mounted) return;
                            Navigator.pop(context, true);
                          }
                        },
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
