import 'package:flutter_test/flutter_test.dart';
import 'package:mon_app_couture/models/fabric.dart';
import 'package:mon_app_couture/features/fabrics/widgets/filters/fabric_filters.dart';
import 'package:mon_app_couture/features/fabrics/controllers/fabrics_controller.dart';
import 'package:mon_app_couture/models/enums/colour.dart';
import 'package:mon_app_couture/models/enums/season.dart';

void main() {
  group('FabricsController', () {
    final controller = FabricsController();

    final fabric1 = Fabric(
      name: 'Coton bleu',
      description: 'Tissu léger pour l’été',
      quantity: 2,
      brand: 'Mercerine',
      colours: [Colour.blue],
      seasons: [Season.summer],
    );

    final fabric2 = Fabric(
      name: 'Jean épais',
      description: 'Parfait pour l’hiver',
      quantity: 3,
      brand: 'Atelier Brunette',
      colours: [Colour.black],
      seasons: [Season.winter],
    );

    final fabric3 = Fabric(
      name: 'Tissu sans info',
      description: '',
      brand: '',
      quantity: null,
      colours: [],
      seasons: [],
    );

    setUp(() {
      controller.allFabrics = [fabric1, fabric2, fabric3];
    });

    test('Sans filtre → tous les tissus sont retournés', () {
      final filters = FabricFilters();
      final result = controller.applyFilters(filters);
      expect(result.length, 3);
    });

    test('Filtre sur mot-clé sans accent → ignore bien les accents', () {
      final filters = FabricFilters(searchTerm: 'ete');
      final result = controller.applyFilters(filters);
      expect(result, contains(fabric1));
    });

    test('Filtre par couleur', () {
      final filters = FabricFilters(selectedColours: {Colour.black});
      final result = controller.applyFilters(filters);
      expect(result, contains(fabric2));
      expect(result, isNot(contains(fabric1)));
    });

    test('Filtre par quantité minimale', () {
      final filters = FabricFilters(minRequiredQuantity: 2.5);
      final result = controller.applyFilters(filters);
      expect(result, contains(fabric2));
      expect(result, isNot(contains(fabric1)));
      expect(result, isNot(contains(fabric3)));
    });
  });
}
