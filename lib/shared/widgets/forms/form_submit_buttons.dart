import 'package:flutter/material.dart';

class FormSubmitButtons extends StatelessWidget {
  final bool isEditing;
  final void Function() onSubmit;
  final Future<void> Function(String) deleteItem; // fonction qui prend un String
  final String itemId;

  const FormSubmitButtons({
    super.key,
    required this.isEditing,
    required this.onSubmit,
    required this.itemId,
    required this.deleteItem,
  });

  @override
  Widget build(BuildContext context) {
    final buttonText = isEditing ? 'Enregistrer' : 'Ajouter';
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: onSubmit, child: Text(buttonText)),
            if (isEditing)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text(
                        'En êtes-vous sûr.e ?',
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
                    await deleteItem(itemId);
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