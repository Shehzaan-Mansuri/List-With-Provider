// test/screens/item_list_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:list_provider/screens/item_list_screen.dart';
import 'package:list_provider/models/item.dart';
import 'package:list_provider/providers/item_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('ItemListScreen displays list of items',
      (WidgetTester tester) async {
    final items = [
      Item(name: 'Item 1', description: 'Description 1'),
      Item(name: 'Item 2', description: 'Description 2'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => ItemProvider()
            ..addItem(items[0])
            ..addItem(items[1]),
          child: ItemListScreen(),
        ),
      ),
    );

    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
  });

  testWidgets('ItemListScreen can delete an item', (WidgetTester tester) async {
    final items = [
      Item(name: 'Item 1', description: 'Description 1'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => ItemProvider()..addItem(items[0]),
          child: ItemListScreen(),
        ),
      ),
    );

    expect(find.byType(ListTile), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    final itemProvider = Provider.of<ItemProvider>(
        tester.element(find.byType(ItemListScreen)),
        listen: false);
    expect(itemProvider.items.length, 0);
  });
}
