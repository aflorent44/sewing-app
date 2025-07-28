import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/models/image_model.dart';
import 'package:mon_app_couture/models/pattern_model.dart';
import 'package:mon_app_couture/services/api/image_service.dart';
import 'package:mon_app_couture/services/api/pattern_service.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_text_field.dart';

class PatternFormData {
  String? id;
  String name;
  String description;
  String brand;
  String format;
  String status;
  String sizeRange;
  List<Season> seasons;
  String typeOfProject;
  List<String> typesOfClothing;
  String sewingLevel;
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
    this.format = '',
    this.status = '',
    this.sizeRange = '',
    List<Season>? seasons,
    this.typeOfProject = '',
    this.typesOfClothing = const [],
    this.sewingLevel = '',
    List<ImageModel>? images,
    this.linkToShop = '',
    this.necessarySupplies = const [],
    this.areSeamAllowancesIncluded = false,
    this.isFavorite = false,
    this.userId = '',
    this.createdAt,
    this.updatedAt,
  }) : seasons = seasons ?? [],
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
      typeOfProject: typeOfProject,
      typesOfClothing: typesOfClothing,
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
      format: p?.format ?? '',
      status: p?.status ?? '',
      sizeRange: p?.sizeRange ?? '',
      seasons: p?.seasons ?? [],
      typeOfProject: p?.typeOfProject ?? '',
      typesOfClothing: p?.typesOfClothing ?? [],
      sewingLevel: p?.sewingLevel ?? '',
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
            'Pattern ${isEditing ? 'modifié' : 'ajouté'} avec succès',
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
                isEditing ? 'Modifier le modèle' : 'Ajouter un modèle',
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
