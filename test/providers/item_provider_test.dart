// test/providers/item_provider_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:list_provider/models/item.dart';
import 'package:list_provider/providers/item_provider.dart';

// test/providers/item_provider_test.dart

void main() {
  late ItemProvider itemProvider;

  setUp(() {
    itemProvider = ItemProvider();
  });

  test('should start with an empty item list', () {
    expect(itemProvider.items, isEmpty);
  });

  test('should add an item correctly', () {
    final item = Item(name: 'Test Item', description: 'Test Description');
    itemProvider.addItem(item);

    expect(itemProvider.items, contains(item));
    expect(itemProvider.successMessage, 'Item added successfully!');
  });

  test('should edit an item correctly', () {
    final item = Item(name: 'Test Item', description: 'Test Description');
    itemProvider.addItem(item);

    final updatedItem =
        Item(name: 'Updated Item', description: 'Updated Description');
    itemProvider.editItem(0, updatedItem);

    expect(itemProvider.items[0], updatedItem);
    expect(itemProvider.successMessage, 'Item edited successfully!');
  });

  test('should remove an item correctly', () {
    final item = Item(name: 'Test Item', description: 'Test Description');
    itemProvider.addItem(item);

    itemProvider.removeItem(0);

    expect(itemProvider.items, isEmpty);
    expect(itemProvider.successMessage, 'Item deleted successfully!');
  });

  test('should clear success message after showing Snackbar', () {
    final item = Item(name: 'Test Item', description: 'Test Description');
    itemProvider.addItem(item);

    expect(itemProvider.successMessage, 'Item added successfully!');

    // Clear success message
    itemProvider.clearSuccessMessage();

    expect(itemProvider.successMessage, '');
  });
}
