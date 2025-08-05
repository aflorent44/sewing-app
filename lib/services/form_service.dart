import 'package:mon_app_couture/models/image_model.dart';

class FormService<T> {
  final Future<void> Function(T item, List<ImageModel> imagesToCreate)
  createFunc;
  final Future<void> Function(
    String id,
    T item,
    List<ImageModel> imagesToCreate,
    List<ImageModel> existingImages,
  )
  updateFunc;
  final Future<void> Function(String imageId) deleteImageFunc;

  FormService({
    required this.createFunc,
    required this.updateFunc,
    required this.deleteImageFunc,
  });

  Future<void> saveOrUpdate({
    required T item,
    required List<ImageModel>? currentImages,
    List<ImageModel>? originalImages,
    String? itemId,
  }) async {
    print("=== DEBUT saveOrUpdate ===");
    final imagesToCreate = currentImages!
        .where((img) => img.id.isEmpty)
        .toList();
    final existingImages = currentImages
        .where((img) => img.id.isNotEmpty)
        .toList();

    final isEditing = itemId != null && itemId.isNotEmpty;
    print("itemId: $itemId");
    print("isEditing: $isEditing");

    if (!isEditing) {
      await createFunc(item, imagesToCreate);
    } else {
      // Supprime les images supprimées
      final imagesToDelete =
          originalImages
              ?.where(
                (orig) => existingImages.every((img) => img.id != orig.id),
              )
              .toList() ??
          [];

      for (final img in imagesToDelete) {
        try {
          await deleteImageFunc(img.id);
        } catch (e) {
          print('Erreur suppression image ${img.id}: $e');
        }
      }

      await updateFunc(itemId, item, imagesToCreate, existingImages);
    }
  }
}
