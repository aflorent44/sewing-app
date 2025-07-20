import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/fabric_pattern.dart';
import 'package:mon_app_couture/models/enums/fabric_status.dart';
import 'package:mon_app_couture/models/enums/fabric_type.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:mon_app_couture/models/material_model.dart';
import 'package:mon_app_couture/services/api/fabric_service.dart';
import 'package:mon_app_couture/services/api/material_service.dart';
import 'package:mon_app_couture/shared/custom_fields.dart/custom_autocomplete_field.dart';
import 'package:mon_app_couture/shared/custom_fields.dart/custom_multiselect_autocomplete_field.dart';
import 'package:mon_app_couture/shared/custom_fields.dart/custom_chip_field.dart';
import 'package:mon_app_couture/shared/custom_fields.dart/custom_multiselect_chip_field.dart';
import 'package:mon_app_couture/shared/custom_fields.dart/custom_numeric_field.dart';
import 'package:mon_app_couture/shared/custom_fields.dart/custom_text_field.dart';

class FabricFormData {
  String? id;
  String name;
  bool isFavorite;
  String description;
  double quantity;
  bool isARemnant;
  int width;
  double extensiveness;
  double price;
  FabricStatus fabricStatus;
  List<Season> seasons;
  List<Colour> colours;
  FabricPattern? fabricPattern;
  FabricType type;
  List<MaterialModel> materials;
  String brand;
  String notes;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;

  FabricFormData({
    this.id,
    this.name = '',
    this.isFavorite = false,
    this.description = '',
    this.quantity = 0.0,
    this.isARemnant = false,
    this.width = 0,
    this.extensiveness = 0.0,
    this.price = 0.0,
    this.fabricStatus = FabricStatus.bought,
    List<Season>? seasons,
    List<Colour>? colours,
    this.type = FabricType.woven,
    this.fabricPattern,
    List<MaterialModel>? materials,
    this.brand = '',
    this.notes = '',
    this.createdAt,
    this.updatedAt,
    this.userId
  }) : seasons = seasons ?? [],
       colours = colours ?? [],
       materials = materials ?? [];

  Fabric toFabric() {
    return Fabric(
      id: id,
      name: name,
      isFavorite: isFavorite,
      description: description,
      quantity: quantity,
      isARemnant: isARemnant,
      width: width,
      extensiveness: extensiveness,
      price: price,
      fabricStatus: fabricStatus,
      seasons: seasons,
      colours: colours,
      fabricPattern: fabricPattern,
      type: type,
      materials: materials,
      brand: brand,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt
    );
  }
}

class FabricFormDialog extends StatefulWidget {
  final Fabric? fabric;

  const FabricFormDialog({super.key, this.fabric});

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

    final f = widget.fabric;
    _formData = FabricFormData(
      id: f?.id,
      name: f?.name ?? '',
      isFavorite: f?.isFavorite ?? false,
      description: f?.description ?? '',
      quantity: f?.quantity ?? 0.0,
      isARemnant: f?.isARemnant ?? false,
      width: f?.width ?? 0,
      extensiveness: f?.extensiveness ?? 0.0,
      price: f?.price ?? 0.0,
      type: f?.type ?? FabricType.woven,
      seasons: f?.seasons ?? [],
      colours: f?.colours ?? [],
      fabricPattern: f?.fabricPattern,
      fabricStatus: f?.fabricStatus ?? FabricStatus.bought,
      materials: f?.materials ?? [],
      brand: f?.brand ?? '',
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

    saveFabricOffline(fabric);

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
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            displayForm(isEditing),
            displayButtons(buttonText, isEditing),
          ],
        ),
      ),
    );
  }

  Widget displayForm(bool isEditing) {
    return Expanded(
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

              CustomTextField(
                label: 'Marque ou boutique',
                initialValue: _formData.brand,
                onSaved: (v) => _formData.brand = v ?? '',
              ),

              Row(
                children: [
                  Expanded(
                    child: Row(
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
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          _formData.isARemnant
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                        onPressed: () {
                          setState(() {
                            _formData.isARemnant = !_formData.isARemnant;
                          });
                        },
                      ),
                      const Text('Chute ?', style: TextStyle(fontSize: 8)),
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: CustomNumericField(
                      label: 'Taux d\'extensivité',
                      initialValue: _formData.extensiveness.toString(),
                      onSaved: (v) => _formData.extensiveness =
                          double.tryParse(v ?? '') ?? 0.0,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomNumericField(
                      label: 'Prix (en €/m)',
                      initialValue: _formData.price.toString(),
                      onSaved: (v) =>
                          _formData.price = double.tryParse(v ?? '') ?? 0,
                    ),
                  ),
                ],
              ),

              CustomChipField<FabricStatus>(
                label: 'Etat',
                values: FabricStatus.values,
                selected: _formData.fabricStatus,
                onChanged: (val) => setState(() => _formData.fabricStatus = val),
                labelBuilder: (s) => s.label,
              ),

              CustomMultiselectChipField<Season>(
                label: 'Saisons',
                values: Season.values,
                selected: _formData.seasons,
                onChanged: (val) => setState(() => _formData.seasons = val),
                labelBuilder: (s) => s.label,
              ),

              CustomMultiselectChipField<Colour>(
                label: 'Couleurs',
                values: Colour.values,
                selected: _formData.colours,
                onChanged: (val) => setState(() => _formData.colours = val),
                chipBuilder: (colour) => colorCircle(colour, 16.0),
              ),

              CustomAutocompleteField(
                label: "Motif",
                options: FabricPattern.values,
                selected: _formData.fabricPattern,
                onChanged: (val) =>
                    setState(() => _formData.fabricPattern = val),
                itemLabelBuilder: (p) => p.label,
              ),

              CustomChipField<FabricType>(
                label: "Type de tissage",
                values: FabricType.values,
                selected: _formData.type,
                onChanged: (val) => setState(() => _formData.type = val),
                labelBuilder: (t) => t.label,
              ),

              CustomMultiselectAutocompleteField<MaterialModel>(
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
                Image.file(_image!, width: 200, height: 200, fit: BoxFit.cover)
              else
                const Text('Aucune image sélectionnée'),

              const SizedBox(height: 8),

              ElevatedButton.icon(
                onPressed: _takePhoto,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Prendre une photo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayButtons(String buttonText, bool isEditing) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    _formData.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: _formData.isFavorite ? Colors.red : Colors.grey,
                  ),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    setState(() {
                      _formData.isFavorite = !_formData.isFavorite;
                    });
                  },
                ),

                const Text('Favori', style: TextStyle(fontSize: 8)),
              ],
            ),
            ElevatedButton(onPressed: _onSubmit, child: Text(buttonText)),
            if (isEditing)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
    );
  }
}
