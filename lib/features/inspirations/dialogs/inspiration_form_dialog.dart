import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/enums/clothing_type.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/pattern_type.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/image_model.dart';
import 'package:mon_app_couture/models/inspiration.dart';
import 'package:mon_app_couture/services/api/image_service.dart';
import 'package:mon_app_couture/services/api/inspiration_service.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_chip_field.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_multiselect_chip_field.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_text_field.dart';
import 'package:mon_app_couture/shared/widgets/custom_image_picker.dart';

class InspirationFormData {
  String? id;
  String name;
  List<Colour> colours;
  List<Season> seasons;
  PatternType projectType;
  List<ClothingType> clothingTypes;
  List<ImageModel> images;
  String link;
  String notes;
  bool isFavorite;
  String userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  InspirationFormData({
    this.id,
    this.name = '',
    List<Colour>? colours,
    List<Season>? seasons,
    this.projectType = PatternType.clothing,
    List<ClothingType>? clothingTypes,
    List<ImageModel>? images,
    this.link = '',
    this.notes = '',
    this.isFavorite = false,
    this.userId = '',
    this.createdAt,
    this.updatedAt,
  }) : colours = colours ?? [],
       seasons = seasons ?? [],
       clothingTypes = clothingTypes ?? [],
       images = images ?? [];

  Inspiration toInspiration() {
    return Inspiration(
      id: id,
      name: name,
      projectType: projectType,
      clothingTypes: clothingTypes,
      colours: colours,
      seasons: seasons,
      images: images,
      link: link,
      notes: notes,
      isFavorite: isFavorite,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: userId,
    );
  }
}

class InspirationFormDialog extends StatefulWidget {
  final Inspiration? inspiration;

  const InspirationFormDialog({super.key, this.inspiration});

  @override
  State<InspirationFormDialog> createState() => _InspirationFormDialogState();
}

class _InspirationFormDialogState extends State<InspirationFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late InspirationFormData _formData;

  @override
  void initState() {
    super.initState();

    final p = widget.inspiration;
    _formData = InspirationFormData(
      id: p?.id,
      name: p?.name ?? '',
      colours: p?.colours ?? [],
      seasons: p?.seasons ?? [],
      projectType: p?.projectType ?? PatternType.clothing,
      clothingTypes: p?.clothingTypes ?? [],
      images: p?.images ?? [],
      link: p?.link ?? '',
      notes: p?.notes ?? '',
      isFavorite: p?.isFavorite ?? false,
      userId: p?.userId ?? '',
      createdAt: p?.createdAt,
      updatedAt: p?.updatedAt,
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final inspiration = _formData.toInspiration();
    final isEditing = widget.inspiration != null;

    try {
      if (!isEditing) {
        // Création : on passe les images à créer
        final imagesToCreate = _formData.images
            .where((img) => img.id.isEmpty)
            .toList();
        await saveInspiration(inspiration, imagesToCreate);
      } else {
        // Modification : on gère les images existantes et nouvelles
        final imagesToCreate = _formData.images
            .where((img) => img.id.isEmpty)
            .toList();
        final existingImages = _formData.images
            .where((img) => img.id.isNotEmpty)
            .toList();

        // Supprimer les images qui ne sont plus dans la liste
        final originalImages = widget.inspiration?.images ?? [];
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
        await updateInspiration(
          inspiration.id!,
          inspiration,
          imagesToCreate,
          existingImages,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Inspiration ${isEditing ? 'modifiée' : 'ajoutée'} avec succès',
          ),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      print('Erreur enregistrement inspiration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.inspiration != null;
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
                isEditing ? 'Modifier l\'inspiration' : 'Ajouter une inspiration',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Nom de l\'inspiration',
                initialValue: _formData.name,
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Veuillez saisir le nom de l\'inspiration'
                    : null,
                onSaved: (v) => _formData.name = v ?? '',
              ),
              CustomChipField(
                label: 'Type de projet',
                values: PatternType.values,
                selected: _formData.projectType,
                onChanged: (val) => setState(() => _formData.projectType = val),
                labelBuilder: (t) => t.label,
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
              CustomMultiselectChipField<Colour>(
                label: 'Couleurs',
                values: Colour.values,
                selected: _formData.colours,
                onChanged: (val) => setState(() => _formData.colours = val),
                chipBuilder: (colour) => colorCircle(colour, 16.0),
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
                },
                type: 'inspiration',
                refId: widget.inspiration?.id,
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
                        'Voulez-vous vraiment supprimer cette inspiration ?',
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
                    await deleteInspiration(widget.inspiration!.id!);
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
