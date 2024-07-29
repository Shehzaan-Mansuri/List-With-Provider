import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemProvider extends ChangeNotifier {
  final List<Item> _items = [];
  String _successMessage = '';

  List<Item> get items => _items;
  String get successMessage => _successMessage;

  void addItem(Item item) {
    _items.add(item);
    _successMessage = 'Item added successfully!';
    notifyListeners();
  }

  void editItem(int index, Item item) {
    _items[index] = item;
    _successMessage = 'Item edited successfully!';
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _successMessage = 'Item deleted successfully!';
    notifyListeners();
  }

  void clearSuccessMessage() {
    _successMessage = '';
    notifyListeners();
  }
}
