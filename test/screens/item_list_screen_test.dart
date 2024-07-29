import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:list_provider/providers/item_provider.dart';
import 'package:list_provider/screens/item_list_screen.dart';
import 'package:list_provider/models/item.dart';

void main() {
  testWidgets('ItemListScreen shows info dialog with app info',
      (WidgetTester tester) async {
    final itemProvider = ItemProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: itemProvider,
          child: const ItemListScreen(),
        ),
      ),
    );

    // Find the info icon in the AppBar and tap it
    final infoAppBarIconFinder = find.byIcon(Icons.info);
    expect(infoAppBarIconFinder, findsOneWidget);
    await tester.tap(infoAppBarIconFinder.first);
    await tester.pumpAndSettle(); // Wait for the dialog to appear

    // Check if the info dialog is displayed
    expect(find.text('About Item Tracker'), findsOneWidget);
    expect(
        find.text(
            'This app allows you to track items. You can add, edit, and delete items.'),
        findsOneWidget);
  });

  testWidgets('ItemListScreen shows RenderBox info dialog',
      (WidgetTester tester) async {
    final itemProvider = ItemProvider();
    itemProvider
        .addItem(Item(name: 'Test Item', description: 'Test Description'));

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: itemProvider,
          child: const ItemListScreen(),
        ),
      ),
    );

    // Trigger a layout to ensure the RenderBox is available
    await tester.pumpAndSettle();

    // Find the info icon for the ListTile and tap it
    final infoListTileIconFinder = find.byIcon(Icons.info);
    expect(infoListTileIconFinder, findsWidgets); // Multiple instances possible

    // Tap the first ListTile info icon
    await tester.tap(infoListTileIconFinder.first);
    await tester.pumpAndSettle(); // Wait for the dialog to appear

    // Check if the RenderBox info dialog is displayed
    expect(find.text('RenderBox Info'), findsOneWidget);

    // Retrieve and print the dialog content for debugging
    final dialogFinder = find.byType(AlertDialog);
    expect(dialogFinder, findsOneWidget);
    final dialog = tester.widget<AlertDialog>(dialogFinder);
    print('Dialog content: ${dialog.content}');
  });

  testWidgets('FloatingActionButton navigates to AddEditItemScreen',
      (WidgetTester tester) async {
    final itemProvider = ItemProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: itemProvider,
          child: const ItemListScreen(),
        ),
      ),
    );

    // Find and tap the FloatingActionButton
    final floatingActionButtonFinder = find.byIcon(Icons.add);
    expect(floatingActionButtonFinder, findsOneWidget);
    await tester.tap(floatingActionButtonFinder);
    await tester.pumpAndSettle(); // Wait for the navigation

    // Check if the AddEditItemScreen is displayed
    expect(find.text('Add Item'), findsOneWidget);
  });

  testWidgets('ListView displays items correctly', (WidgetTester tester) async {
    final itemProvider = ItemProvider();
    itemProvider
        .addItem(Item(name: 'Test Item', description: 'Test Description'));

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: itemProvider,
          child: const ItemListScreen(),
        ),
      ),
    );

    // Check if the ListView displays the added item
    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
  });
}
