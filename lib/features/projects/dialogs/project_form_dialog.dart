import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:mon_app_couture/models/image_model.dart';
import 'package:mon_app_couture/models/inspiration.dart';
import 'package:mon_app_couture/models/pattern_model.dart';
import 'package:mon_app_couture/models/project.dart';
import 'package:mon_app_couture/services/api/fabric_service.dart';
import 'package:mon_app_couture/services/api/image_service.dart';
import 'package:mon_app_couture/services/api/pattern_service.dart';
import 'package:mon_app_couture/services/api/project_service.dart';
import 'package:mon_app_couture/services/api/inspiration_service.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_autocomplete_field.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_text_field.dart';
import 'package:mon_app_couture/shared/widgets/custom_image_picker.dart';
import 'package:collection/collection.dart';

class ProjectFormData {
  String? id;
  String name;
  String notes;
  List<ImageModel> images;
  String? inspirationId;
  String? patternId;
  String? fabricId;
  bool isFavorite;
  String userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProjectFormData({
    this.id,
    this.name = '',
    this.notes = '',
    List<ImageModel>? images,
    this.inspirationId,
    this.patternId,
    this.fabricId,
    this.isFavorite = false,
    this.userId = '',
    this.createdAt,
    this.updatedAt,
  }) : images = images ?? [];

  Project toProject() {
    return Project(
      id: id,
      name: name,
      notes: notes,
      images: images,
      inspirationId: inspirationId,
      patternId: patternId,
      fabricId: fabricId,
      isFavorite: isFavorite,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: userId,
    );
  }
}

class ProjectFormDialog extends StatefulWidget {
  final Project? project;

  const ProjectFormDialog({super.key, this.project});

  @override
  State<ProjectFormDialog> createState() => _ProjectFormDialogState();
}

class _ProjectFormDialogState extends State<ProjectFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late ProjectFormData _formData;
  List<Inspiration> _allInspirations = [];
  List<PatternModel> _allPatterns = [];
  List<Fabric> _allFabrics = [];

  @override
  void initState() {
    super.initState();

    final p = widget.project;
    _formData = ProjectFormData(
      id: p?.id,
      name: p?.name ?? '',
      notes: p?.notes ?? '',
      images: p?.images ?? [],
      inspirationId: p?.inspirationId,
      patternId: p?.patternId,
      fabricId: p?.fabricId,
      isFavorite: p?.isFavorite ?? false,
      userId: p?.userId ?? '',
      createdAt: p?.createdAt,
      updatedAt: p?.updatedAt,
    );

    _loadInspirations();
    _loadPatterns();
    _loadFabrics();
  }

  Future<void> _loadInspirations() async {
    try {
      final inspirations = await fetchInspirations();
      setState(() {
        _allInspirations = inspirations;
      });
    } catch (e) {
      print("Erreur chargement inspirations : $e");
    }
  }

  Future<void> _loadPatterns() async {
    try {
      final patterns = await fetchPatterns();
      setState(() {
        _allPatterns = patterns;
      });
    } catch (e) {
      print("Erreur chargement patterns : $e");
    }
  }

  Future<void> _loadFabrics() async {
    try {
      final fabrics = await fetchFabrics();
      setState(() {
        _allFabrics = fabrics;
      });
    } catch (e) {
      print("Erreur chargement fabrics : $e");
    }
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final project = _formData.toProject();
    final isEditing = widget.project != null;

    try {
      if (!isEditing) {
        // Création : on passe les images à créer
        final imagesToCreate = _formData.images
            .where((img) => img.id.isEmpty)
            .toList();
        await saveProject(project, imagesToCreate);
      } else {
        // Modification : on gère les images existantes et nouvelles
        final imagesToCreate = _formData.images
            .where((img) => img.id.isEmpty)
            .toList();
        final existingImages = _formData.images
            .where((img) => img.id.isNotEmpty)
            .toList();

        // Supprimer les images qui ne sont plus dans la liste
        final originalImages = widget.project?.images ?? [];
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
        await updateProject(
          project.id!,
          project,
          imagesToCreate,
          existingImages,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Projet ${isEditing ? 'modifié' : 'ajouté'} avec succès',
          ),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      print('Erreur enregistrement projet: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.project != null;
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
                isEditing ? 'Modifier le projet' : 'Ajouter un projet',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Nom du projet',
                initialValue: _formData.name,
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Veuillez saisir le nom du projet'
                    : null,
                onSaved: (v) => _formData.name = v ?? '',
              ),
              CustomAutocompleteField<Inspiration>(
                label: 'Inspiration',
                options: _allInspirations,
                selected: _allInspirations.firstWhereOrNull(
                  (i) => i.id == _formData.inspirationId,
                ),
                onChanged: (newValue) {
                  setState(() {
                    _formData.inspirationId = newValue?.id;
                  });
                },
                itemLabelBuilder: (i) => i.name,
              ),
              CustomAutocompleteField<PatternModel>(
                label: 'Patron',
                options: _allPatterns,
                selected: _allPatterns.firstWhereOrNull(
                  (i) => i.id == _formData.patternId,
                ),
                onChanged: (newValue) {
                  setState(() {
                    _formData.patternId = newValue?.id;
                  });
                },
                itemLabelBuilder: (p) => p.name,
              ),
              CustomAutocompleteField<Fabric>(
                label: 'Tissu',
                options: _allFabrics,
                selected: _allFabrics.firstWhereOrNull(
                  (i) => i.id == _formData.fabricId,
                ),
                onChanged: (newValue) {
                  setState(() {
                    _formData.fabricId = newValue?.id;
                  });
                },
                itemLabelBuilder: (f) => f.name,
              ),
              CustomTextField(
                label: 'Notes',
                initialValue: _formData.notes,
                onSaved: (v) => _formData.notes = v ?? '',
              ),
              CustomImagePicker(
                onImagesSelected: (images) {
                  setState(() {
                    _formData.images = images;
                  });
                },
                type: 'project',
                refId: widget.project?.id,
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
                        'Voulez-vous vraiment supprimer ce projet ?',
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
                    await deleteProject(widget.project!.id!);
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
