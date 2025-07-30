import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/enums/clothing_type.dart';
import 'package:mon_app_couture/models/enums/fabric_type.dart';
import 'package:mon_app_couture/models/enums/pattern_format.dart';
import 'package:mon_app_couture/models/enums/pattern_status.dart';
import 'package:mon_app_couture/models/enums/pattern_type.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/enums/sewing_level.dart';
import 'package:mon_app_couture/models/enums/wearer_category.dart';
import 'package:mon_app_couture/models/image_model.dart';
import 'package:mon_app_couture/models/pattern_model.dart';
import 'package:mon_app_couture/services/api/image_service.dart';
import 'package:mon_app_couture/services/api/pattern_service.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_chip_field.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_multiselect_chip_field.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_text_field.dart';
import 'package:mon_app_couture/shared/widgets/custom_image_picker.dart';

class PatternFormData {
  String? id;
  String name;
  String description;
  String brand;
  PatternFormat format;
  PatternStatus status;
  String sizeRange;
  List<Season> seasons;
  List<FabricType> fabricTypes;
  PatternType projectType;
  List<WearerCategory> wearerCategories;
  List<ClothingType> clothingTypes;
  SewingLevel sewingLevel;
  List<ImageModel> images;
  String linkToShop;
  List<String> necessarySupplies;
  bool areSeamAllowancesIncluded;
  bool isFavorite;
  String userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  PatternFormData({
    this.id,
    this.name = '',
    this.description = '',
    this.brand = '',
    this.format = PatternFormat.pdf,
    this.status = PatternStatus.printed,
    this.sizeRange = '',
    List<Season>? seasons,
    List<FabricType>? fabricTypes,
    this.projectType = PatternType.clothing,
    List<WearerCategory>? wearerCategories,
    List<ClothingType>? clothingTypes,
    this.sewingLevel = SewingLevel.easy,
    List<ImageModel>? images,
    this.linkToShop = '',
    this.necessarySupplies = const [],
    this.areSeamAllowancesIncluded = false,
    this.isFavorite = false,
    this.userId = '',
    this.createdAt,
    this.updatedAt,
  }) : seasons = seasons ?? [],
       fabricTypes = (fabricTypes?.isNotEmpty ?? false)
           ? fabricTypes!
           : [FabricType.woven],
       wearerCategories = wearerCategories ?? [],
       clothingTypes = clothingTypes ?? [],
       images = images ?? [];

  PatternModel toPattern() {
    return PatternModel(
      id: id,
      name: name,
      description: description,
      brand: brand,
      format: format,
      status: status,
      sizeRange: sizeRange,
      seasons: seasons,
      fabricTypes: fabricTypes,
      projectType: projectType,
      wearerCategories: wearerCategories,
      clothingTypes: clothingTypes,
      sewingLevel: sewingLevel,
      images: images,
      linkToShop: linkToShop,
      necessarySupplies: necessarySupplies,
      areSeamAllowancesIncluded: areSeamAllowancesIncluded,
      isFavorite: isFavorite,
      userId: userId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class PatternFormDialog extends StatefulWidget {
  final PatternModel? pattern;

  const PatternFormDialog({super.key, this.pattern});

  @override
  State<PatternFormDialog> createState() => _PatternFormDialogState();
}

class _PatternFormDialogState extends State<PatternFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late PatternFormData _formData;

  @override
  void initState() {
    super.initState();

    final p = widget.pattern;
    _formData = PatternFormData(
      id: p?.id,
      name: p?.name ?? '',
      description: p?.description ?? '',
      brand: p?.brand ?? '',
      format: p?.format ?? PatternFormat.pdf,
      status: p?.status ?? PatternStatus.printed,
      sizeRange: p?.sizeRange ?? '',
      seasons: p?.seasons ?? [],
      fabricTypes: (p?.fabricTypes?.isNotEmpty ?? false)
          ? p!.fabricTypes
          : [FabricType.woven],
      projectType: p?.projectType ?? PatternType.clothing,
      wearerCategories: p?.wearerCategories ?? [],
      clothingTypes: p?.clothingTypes ?? [],
      sewingLevel: p?.sewingLevel ?? SewingLevel.easy,
      images: p?.images ?? [],
      linkToShop: p?.linkToShop ?? '',
      necessarySupplies: p?.necessarySupplies ?? [],
      areSeamAllowancesIncluded: p?.areSeamAllowancesIncluded ?? false,
      isFavorite: p?.isFavorite ?? false,
      userId: p?.userId ?? '',
      createdAt: p?.createdAt,
      updatedAt: p?.updatedAt,
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final pattern = _formData.toPattern();
    final isEditing = widget.pattern != null;

    try {
      if (!isEditing) {
        // Création : on passe les images à créer
        final imagesToCreate = _formData.images
            .where((img) => img.id.isEmpty)
            .toList();
        await savePattern(pattern, imagesToCreate);
      } else {
        // Modification : on gère les images existantes et nouvelles
        final imagesToCreate = _formData.images
            .where((img) => img.id.isEmpty)
            .toList();
        final existingImages = _formData.images
            .where((img) => img.id.isNotEmpty)
            .toList();

        // Supprimer les images qui ne sont plus dans la liste
        final originalImages = widget.pattern?.images ?? [];
        final imagesToDelete = originalImages
            .where(
              (original) =>
                  !existingImages.any((current) => current.id == original.id),
            )
            .toList();
        for (final image in imagesToDelete) {
          try {
            await deleteImageById(image.id);
          } catch (e) {
            print('Erreur suppression image ${image.id}: $e');
          }
        }
        await updatePattern(
          pattern.id!,
          pattern,
          imagesToCreate,
          existingImages,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Patron ${isEditing ? 'modifié' : 'ajouté'} avec succès',
          ),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      print('Erreur enregistrement pattern: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.pattern != null;
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
                isEditing ? 'Modifier le patron' : 'Ajouter un patron',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Nom du patron',
                initialValue: _formData.name,
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Veuillez saisir le nom du patron'
                    : null,
                onSaved: (v) => _formData.name = v ?? '',
              ),
              CustomTextField(
                label: 'Description',
                initialValue: _formData.description,
                onSaved: (v) => _formData.description = v ?? '',
              ),
              CustomTextField(
                label: 'Marque',
                initialValue: _formData.brand,
                onSaved: (v) => _formData.brand = v ?? '',
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      _formData.areSeamAllowancesIncluded
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                    onPressed: () {
                      setState(() {
                        _formData.areSeamAllowancesIncluded =
                            !_formData.areSeamAllowancesIncluded;
                      });
                    },
                  ),
                  const Text(
                    'Marges incluses ?',
                    style: TextStyle(fontSize: 8),
                  ),
                ],
              ),
              CustomChipField<PatternFormat>(
                label: 'Format',
                values: PatternFormat.values,
                selected: _formData.format,
                onChanged: (val) => setState(() => _formData.format = val),
                labelBuilder: (f) => f.label,
              ),
              CustomChipField<PatternStatus>(
                label: 'Statut',
                values: switch (_formData.format) {
                  PatternFormat.pdf => [
                    PatternStatus.bought,
                    PatternStatus.printed,
                    PatternStatus.cut,
                    PatternStatus.assembled,
                    PatternStatus.transfered,
                  ],
                  PatternFormat.printed => [
                    PatternStatus.ordered,
                    PatternStatus.received,
                    PatternStatus.transfered,
                  ],
                  PatternFormat.magazine => [
                    PatternStatus.ordered,
                    PatternStatus.received,
                    PatternStatus.transfered,
                  ],
                  PatternFormat.livre => [
                    PatternStatus.ordered,
                    PatternStatus.received,
                    PatternStatus.transfered,
                  ],
                  PatternFormat.autre => [
                    PatternStatus.ordered,
                    PatternStatus.bought,
                    PatternStatus.received,
                    PatternStatus.printed,
                    PatternStatus.cut,
                    PatternStatus.assembled,
                    PatternStatus.transfered,
                  ],
                },
                selected: _formData.status,
                onChanged: (val) => setState(() => _formData.status = val),
                labelBuilder: (s) => s.label,
              ),
              CustomChipField(
                label: 'Type de projet',
                values: PatternType.values,
                selected: _formData.projectType,
                onChanged: (val) => setState(() => _formData.projectType = val),
                labelBuilder: (t) => t.label,
              ),
              if (_formData.projectType == PatternType.clothing ||
                  _formData.projectType == PatternType.underwearAndSwimwear)
                CustomTextField(
                  label: 'Taille',
                  initialValue: _formData.sizeRange,
                  onSaved: (v) => _formData.sizeRange = v ?? '',
                ),
              if (_formData.projectType == PatternType.clothing)
                CustomMultiselectChipField(
                  label: 'Cible',
                  values: WearerCategory.values,
                  selected: _formData.wearerCategories,
                  onChanged: (val) =>
                      setState(() => _formData.wearerCategories = val),
                  labelBuilder: (c) => c.label,
                ),
              if (_formData.projectType == PatternType.clothing)
                CustomMultiselectChipField(
                  label: 'Types de vêtements',
                  values: ClothingType.values,
                  selected: _formData.clothingTypes,
                  onChanged: (val) =>
                      setState(() => _formData.clothingTypes = val),
                  labelBuilder: (c) => c.label,
                ),
              CustomChipField(
                label: 'Niveau de difficulté',
                values: SewingLevel.values,
                selected: _formData.sewingLevel,
                onChanged: (val) => setState(() => _formData.sewingLevel = val),
                labelBuilder: (l) => l.label,
              ),
              CustomMultiselectChipField<Season>(
                label: 'Saisons',
                values: Season.values,
                selected: _formData.seasons,
                onChanged: (val) => setState(() => _formData.seasons = val),
                labelBuilder: (s) => s.label,
              ),

              CustomImagePicker(
                onImagesSelected: (images) {
                  setState(() {
                    _formData.images = images;
                  });
                  print("onImagesSelected : $images");
                },
                type: 'pattern',
                refId: widget.pattern?.id,
                initialImages: _formData.images,
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
                        'Voulez-vous vraiment supprimer ce patron ?',
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
                    await deletePattern(widget.pattern!.id!);
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
