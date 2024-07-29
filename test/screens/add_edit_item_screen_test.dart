import 'package:flutter/material.dart';
import 'package:list_provider/models/item.dart';
import 'package:list_provider/widgets/text_form_field.dart';

class AddEditItemScreen extends StatefulWidget {
  final Item? item;
  final int? index;
  final Function(Item)? onItemAdded;
  final Function(Item)? onItemUpdated;

  const AddEditItemScreen({
    super.key,
    this.item,
    this.index,
    this.onItemAdded,
    this.onItemUpdated,
  });

  @override
  _AddEditItemScreenState createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.item?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveItem() {
    if (_formKey.currentState?.validate() ?? false) {
      final item = Item(
        id: widget.item?.id,
        name: _nameController.text,
        description: _descriptionController.text,
      );
      if (widget.item == null) {
        // Adding a new item
        widget.onItemAdded?.call(item);
      } else {
        // Editing an existing item
        widget.onItemUpdated?.call(item);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Add Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _nameController,
                labelText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _descriptionController,
                labelText: 'Description',
                isMultiline: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveItem,
                child: Text(widget.item == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
