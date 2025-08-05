import 'package:flutter/material.dart';
import 'package:mon_app_couture/models/inspiration.dart';
import 'package:mon_app_couture/services/form_service.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_chip_field.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_multiselect_chip_field.dart';
import 'package:mon_app_couture/shared/fields.dart/custom_text_field.dart';
import 'package:mon_app_couture/shared/widgets/forms/custom_image_picker.dart';
import 'package:mon_app_couture/models/enums/clothing_type.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/pattern_type.dart';
import 'package:mon_app_couture/models/enums/season.dart';
import 'package:mon_app_couture/services/api/inspiration_service.dart';
import 'package:mon_app_couture/services/api/image_service.dart';
import 'package:mon_app_couture/shared/widgets/forms/form_submit_buttons.dart';

class InspirationFormDialog extends StatefulWidget {
  final Inspiration? inspiration;

  const InspirationFormDialog({super.key, this.inspiration});

  @override
  State<InspirationFormDialog> createState() => _InspirationFormDialogState();
}

class _InspirationFormDialogState extends State<InspirationFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late Inspiration _formData;

  final formService = FormService<Inspiration>(
    createFunc: saveInspiration,
    updateFunc: updateInspiration,
    deleteImageFunc: deleteImageById,
  );

  @override
  void initState() {
    super.initState();

    _formData =
        widget.inspiration ??
        Inspiration(
          id: null,
          name: '',
          projectType: PatternType.clothing,
          clothingTypes: [],
          colours: [],
          seasons: [],
          images: [],
          link: '',
          notes: '',
          isFavorite: false,
          userId: '',
          createdAt: null,
          updatedAt: null,
        );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    try {
      await formService.saveOrUpdate(
        item: _formData,
        currentImages: _formData.images ?? [],
        originalImages: widget.inspiration?.images ?? [],
        itemId: widget.inspiration?.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.inspiration == null
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
    final isEditing = widget.inspiration != null;
    return Dialog(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: _buildForm(isEditing)),
            FormSubmitButtons(
              isEditing: isEditing,
              onSubmit: _onSubmit,
              itemId: _formData.id ?? '',
              deleteItem: deleteInspiration,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(bool isEditing) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEditing ? 'Modifier l\'inspiration' : 'Ajouter une inspiration',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Nom de l\'inspiration',
              initialValue: _formData.name,
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Veuillez saisir un nom' : null,
              onSaved: (val) => setState(() {
                _formData = _formData.copyWith(name: val ?? '');
              }),
            ),
            const SizedBox(height: 12),
            CustomChipField<PatternType>(
              label: 'Type de projet',
              values: PatternType.values,
              selected: _formData.projectType ?? PatternType.clothing,
              onChanged: (val) => setState(() {
                _formData = _formData.copyWith(projectType: val);
              }),
              labelBuilder: (t) => t.label,
            ),
            if (_formData.projectType == PatternType.clothing) ...[
              const SizedBox(height: 12),
              CustomMultiselectChipField<ClothingType>(
                label: 'Types de vêtements',
                values: ClothingType.values,
                selected: _formData.clothingTypes ?? [],
                onChanged: (val) => setState(() {
                  _formData = _formData.copyWith(clothingTypes: val);
                }),
                labelBuilder: (c) => c.label,
              ),
            ],
            const SizedBox(height: 12),
            CustomMultiselectChipField<Colour>(
              label: 'Couleurs',
              values: Colour.values,
              selected: _formData.colours ?? [],
              onChanged: (val) => setState(() {
                _formData = _formData.copyWith(colours: val);
              }),
              chipBuilder: (colour) => colorCircle(colour, 16),
            ),
            const SizedBox(height: 12),
            CustomMultiselectChipField<Season>(
              label: 'Saisons',
              values: Season.values,
              selected: _formData.seasons ?? [],
              onChanged: (val) => setState(() {
                _formData = _formData.copyWith(seasons: val);
              }),
              labelBuilder: (s) => s.label,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              label: 'Lien',
              initialValue: _formData.link ?? '',
              onSaved: (val) => setState(() {
                _formData = _formData.copyWith(link: val ?? '');
              }),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              label: 'Notes',
              initialValue: _formData.notes ?? '',
              onSaved: (val) => setState(() {
                _formData = _formData.copyWith(notes: val ?? '');
              }),
            ),
            const SizedBox(height: 12),
            CustomImagePicker(
              onImagesSelected: (images) => setState(() {
                _formData = _formData.copyWith(images: images);
              }),
              type: 'inspiration',
              refId: _formData.id,
              initialImages: _formData.images ?? [],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    (_formData.isFavorite ?? false)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: (_formData.isFavorite ?? false)
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: () => setState(() {
                    _formData = _formData.copyWith(
                      isFavorite: !(_formData.isFavorite ?? false),
                    );
                  }),
                ),
                const Text('Favori'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
