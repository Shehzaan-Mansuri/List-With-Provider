import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_provider/screens/add_edit_item_screen.dart';
import 'package:list_provider/models/item.dart';

void main() {
  testWidgets('AddEditItemScreen displays correctly for editing an item',
      (WidgetTester tester) async {
    final testItem = Item(name: 'Test Item', description: 'Test Description');

    await tester.pumpWidget(
      MaterialApp(
        home: AddEditItemScreen(
          item: testItem,
          index: 0,
          onItemUpdated: (updatedItem) {
            // Handle item update
          },
        ),
      ),
    );

    // Check if the screen displays the existing item details
    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
  });

  testWidgets('AddEditItemScreen adds a new item correctly',
      (WidgetTester tester) async {
    bool itemAdded = false;
    Item? addedItem;

    await tester.pumpWidget(
      MaterialApp(
        home: AddEditItemScreen(
          onItemAdded: (newItem) {
            itemAdded = true;
            addedItem = newItem;
          },
        ),
      ),
    );

    // Enter new item details
    await tester.enterText(find.byType(TextFormField).at(0), 'New Item');
    await tester.enterText(find.byType(TextFormField).at(1), 'New Description');
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Verify if the new item is added
    expect(itemAdded, isTrue);
    expect(addedItem?.name, 'New Item');
    expect(addedItem?.description, 'New Description');
  });

  testWidgets('AddEditItemScreen updates an existing item correctly',
      (WidgetTester tester) async {
    bool itemUpdated = false;
    Item? updatedItem;

    final testItem = Item(name: 'Test Item', description: 'Test Description');

    await tester.pumpWidget(
      MaterialApp(
        home: AddEditItemScreen(
          item: testItem,
          index: 0,
          onItemUpdated: (item) {
            itemUpdated = true;
            updatedItem = item;
          },
        ),
      ),
    );

    // Enter updated item details
    await tester.enterText(find.byType(TextFormField).at(0), 'Updated Item');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'Updated Description');
    await tester.tap(find.text('Save'));
    await tester.pump();

    // Verify if the item is updated
    expect(itemUpdated, isTrue);
    expect(updatedItem?.name, 'Updated Item');
    expect(updatedItem?.description, 'Updated Description');
  });

  testWidgets('AddEditItemScreen shows validation error when fields are empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AddEditItemScreen(
          onItemAdded: (newItem) {},
        ),
      ),
    );

    // Tap the 'Add' button without entering any data
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Check for validation error messages
    expect(find.text('Name is required'), findsOneWidget);
    expect(find.text('Description is required'), findsOneWidget);
  });

  testWidgets(
      'AddEditItemScreen shows correct button label for adding vs editing',
      (WidgetTester tester) async {
    final testItem = Item(name: 'Test Item', description: 'Test Description');

    // Test 'Add' button
    await tester.pumpWidget(
      MaterialApp(
        home: AddEditItemScreen(
          onItemAdded: (newItem) {},
        ),
      ),
    );
    expect(find.text('Add'), findsOneWidget);

    // Test 'Save' button
    await tester.pumpWidget(
      MaterialApp(
        home: AddEditItemScreen(
          item: testItem,
          index: 0,
          onItemUpdated: (updatedItem) {},
        ),
      ),
    );
    expect(find.text('Save'), findsOneWidget);
  });
}
