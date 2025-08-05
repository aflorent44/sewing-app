import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:mon_app_couture/models/inspiration.dart';
import 'package:mon_app_couture/models/pattern_model.dart';
import 'package:mon_app_couture/models/project.dart';
import 'package:mon_app_couture/services/api/fabric_service.dart';
import 'package:mon_app_couture/services/api/image_service.dart';
import 'package:mon_app_couture/services/api/pattern_service.dart';
import 'package:mon_app_couture/services/api/project_service.dart';
import 'package:mon_app_couture/services/api/inspiration_service.dart';
import 'package:mon_app_couture/services/form_service.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_autocomplete_field.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_text_field.dart';
import 'package:mon_app_couture/shared/widgets/forms/custom_image_picker.dart';
import 'package:collection/collection.dart';
import 'package:mon_app_couture/shared/widgets/forms/form_submit_buttons.dart';

class ProjectFormDialog extends StatefulWidget {
  final Project? project;

  const ProjectFormDialog({super.key, this.project});

  @override
  State<ProjectFormDialog> createState() => _ProjectFormDialogState();
}

class _ProjectFormDialogState extends State<ProjectFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late Project _formData;

  final formService = FormService<Project>(
    createFunc: saveProject,
    updateFunc: updateProject,
    deleteImageFunc: deleteImageById,
  );
  List<Inspiration> _allInspirations = [];
  List<PatternModel> _allPatterns = [];
  List<Fabric> _allFabrics = [];

  Key _inspirationKey = UniqueKey();
  Key _patternKey = UniqueKey();
  Key _fabricKey = UniqueKey();

  @override
  void initState() {
    super.initState();

    _formData =
        widget.project ??
        Project(
          id: null,
          name: '',
          notes: '',
          images: [],
          inspirationId: null,
          patternId: null,
          fabricId: null,
          isFavorite: false,
          createdAt: null,
          updatedAt: null,
          userId: '',
        );

            print('DEBUG Project reçu: ${widget.project != null ? 'OUI' : 'NON'}');
    if (widget.project != null) {
      print('DEBUG Project ID: ${widget.project!.id}');
      print('DEBUG Project Name: ${widget.project!.name}');
      print('DEBUG Project inspirationId: ${widget.project!.inspirationId}');
      print('DEBUG Project patternId: ${widget.project!.patternId}');
      print('DEBUG Project fabricId: ${widget.project!.fabricId}');
    }

    _loadAllData();
  }

  Future<void> _loadAllData() async {
    await Future.wait([_loadInspirations(), _loadPatterns(), _loadFabrics()]);

    // Forcer le rebuild des autocomplete après chargement
    if (mounted) {
      setState(() {
        _inspirationKey = UniqueKey();
        _patternKey = UniqueKey();
        _fabricKey = UniqueKey();
      });
    }
  }

  Future<void> _loadInspirations() async {
    try {
      final inspirations = await fetchInspirations();
      if (mounted) {
        setState(() {
          _allInspirations = inspirations;
        });
      }
    } catch (e) {
      print("Erreur chargement inspirations : $e");
    }
  }

  Future<void> _loadPatterns() async {
    try {
      final patterns = await fetchPatterns();
      if (mounted) {
        setState(() {
          _allPatterns = patterns;
        });
      }
    } catch (e) {
      print("Erreur chargement patterns : $e");
    }
  }

  Future<void> _loadFabrics() async {
    try {
      final fabrics = await fetchFabrics();
      if (mounted) {
        setState(() {
          _allFabrics = fabrics;
        });
      }
    } catch (e) {
      print("Erreur chargement fabrics : $e");
    }
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    try {
      await formService.saveOrUpdate(
        item: _formData,
        currentImages: _formData.images ?? [],
        originalImages: widget.project?.images ?? [],
        itemId: widget.project?.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.project == null
                ? 'Inspiration ajoutée avec succès'
                : 'Inspiration modifiée avec succès',
          ),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      print('Erreur enregistrement inspiration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de l\'enregistrement')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.project != null;
    return Dialog(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            displayForm(isEditing),
            FormSubmitButtons(
              isEditing: isEditing,
              onSubmit: _onSubmit,
              itemId: _formData.id ?? '',
              deleteItem: deleteProject,
            ),
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
                onSaved: (val) => setState(() {
                  _formData = _formData.copyWith(name: val ?? '');
                }),
              ),
              Builder(
                builder: (context) {
                  final selectedInspiration = _allInspirations.firstWhereOrNull(
                    (i) => i.id == _formData.inspirationId,
                  );
                  print(
                    'DEBUG Inspiration - ID recherché: ${_formData.inspirationId}',
                  );
                  print(
                    'DEBUG Inspiration - Trouvé: ${selectedInspiration?.name ?? 'null'}',
                  );
                  print(
                    'DEBUG Inspiration - Total options: ${_allInspirations.length}',
                  );

                  return CustomAutocompleteField<Inspiration>(
                    key: _inspirationKey,
                    label: 'Inspiration',
                    options: _allInspirations,
                    selected: selectedInspiration,
                    onChanged: (val) {
                      setState(() {
                        _formData = _formData.copyWith(inspirationId: val?.id);
                      });
                    },
                    itemLabelBuilder: (i) => i.name,
                  );
                },
              ),
              Builder(
                builder: (context) {
                  final selectedPattern = _allPatterns.firstWhereOrNull(
                    (i) => i.id == _formData.patternId,
                  );
                  print('DEBUG Pattern - ID recherché: ${_formData.patternId}');
                  print(
                    'DEBUG Pattern - Trouvé: ${selectedPattern?.name ?? 'null'}',
                  );
                  print(
                    'DEBUG Pattern - Total options: ${_allPatterns.length}',
                  );

                  return CustomAutocompleteField<PatternModel>(
                    key: _patternKey,
                    label: 'Patron',
                    options: _allPatterns,
                    selected: selectedPattern,
                    onChanged: (val) {
                      setState(() {
                        _formData = _formData.copyWith(patternId: val?.id);
                      });
                    },
                    itemLabelBuilder: (p) => p.name,
                  );
                },
              ),
              Builder(
                builder: (context) {
                  final selectedFabric = _allFabrics.firstWhereOrNull(
                    (i) => i.id == _formData.fabricId,
                  );
                  print('DEBUG Fabric - ID recherché: ${_formData.fabricId}');
                  print(
                    'DEBUG Fabric - Trouvé: ${selectedFabric?.name ?? 'null'}',
                  );
                  print(
                    'DEBUG Fabric - Total options: ${_allFabrics.length}',
                  );

                  return CustomAutocompleteField<Fabric>(
                    key: _fabricKey,
                    label: 'Tissu',
                    options: _allFabrics,
                    selected: selectedFabric,
                    onChanged: (val) {
                      setState(() {
                        _formData = _formData.copyWith(fabricId: val?.id);
                      });
                    },
                    itemLabelBuilder: (f) => f.name,
                  );
                },
              ),
              CustomTextField(
                label: 'Notes',
                initialValue: _formData.notes,
                onSaved: (v) => _formData = _formData.copyWith(notes: v ?? ''),
              ),
              CustomImagePicker(
                onImagesSelected: (images) {
                  setState(() {
                    _formData = _formData.copyWith(images: images);
                  });
                },
                type: 'project',
                refId: widget.project?.id,
                initialImages: _formData.images ?? [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
