import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/item_provider.dart';
import 'screens/item_list_screen.dart';

void main() => runApp(const ItemTrackerApp());

class ItemTrackerApp extends StatelessWidget {
  const ItemTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Item Tracker',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const ItemListScreen(),
      ),
    );
  }
}
