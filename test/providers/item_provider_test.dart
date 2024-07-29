import 'package:flutter_test/flutter_test.dart';
import 'package:list_provider/providers/item_provider.dart';
import 'package:list_provider/models/item.dart';

void main() {
  test('Initial state is correct', () {
    final itemProvider = ItemProvider();

    expect(itemProvider.items, isEmpty);
    expect(itemProvider.successMessage, isEmpty);
  });

  test('Add item updates list and success message', () {
    final itemProvider = ItemProvider();
    final item = Item(name: 'Test Item', description: 'Test Description');

    itemProvider.addItem(item);

    expect(itemProvider.items.length, 1);
    expect(itemProvider.items[0], item);
    expect(itemProvider.successMessage, 'Item added successfully!');
  });

  test('Edit item updates item and success message', () {
    final itemProvider = ItemProvider();
    final item1 = Item(name: 'Test Item', description: 'Test Description');
    final item2 =
        Item(name: 'Updated Item', description: 'Updated Description');

    itemProvider.addItem(item1);
    itemProvider.editItem(0, item2);

    expect(itemProvider.items.length, 1);
    expect(itemProvider.items[0], item2);
    expect(itemProvider.successMessage, 'Item edited successfully!');
  });

  test('Remove item updates list and success message', () {
    final itemProvider = ItemProvider();
    final item = Item(name: 'Test Item', description: 'Test Description');

    itemProvider.addItem(item);
    itemProvider.removeItem(0);

    expect(itemProvider.items, isEmpty);
    expect(itemProvider.successMessage, 'Item deleted successfully!');
  });

  test('Clear success message', () {
    final itemProvider = ItemProvider();
    final item = Item(name: 'Test Item', description: 'Test Description');

    itemProvider.addItem(item);
    itemProvider.clearSuccessMessage();

    expect(itemProvider.successMessage, isEmpty);
  });
}
