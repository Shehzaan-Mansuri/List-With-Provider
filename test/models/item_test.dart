// test/models/item_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:list_provider/models/item.dart';

void main() {
  group('Item Model', () {
    test('should create an item with the given name and description', () {
      final item = Item(name: 'Test Item', description: 'Test Description');

      expect(item.name, 'Test Item');
      expect(item.description, 'Test Description');
    });
  });
}
