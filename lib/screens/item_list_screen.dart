import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import 'add_edit_item_screen.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Text('About Item Tracker'),
                  content: Text(
                      'This app allows you to track items. You can add, edit, and delete items.'),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (itemProvider.successMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(itemProvider.successMessage),
                  duration: const Duration(seconds: 2),
                ),
              );
              // Clear the success message after showing the SnackBar
              itemProvider.clearSuccessMessage();
            }
          });

          return ListView.builder(
            itemCount: itemProvider.items.length,
            itemBuilder: (context, index) {
              final item = itemProvider.items[index];
              final GlobalKey key = GlobalKey();

              return Card(
                child: ListTile(
                  key: key,
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddEditItemScreen(
                                item: item,
                                index: index,
                                onItemUpdated: (editedItem) {
                                  context
                                      .read<ItemProvider>()
                                      .editItem(index, editedItem);
                                },
                              ),
                            ),
                          );

                          // If update was successful, the provider will handle success message
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<ItemProvider>().removeItem(index);
                          // The Snackbar will be shown by the Consumer in the build method
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.info),
                        onPressed: () {
                          final RenderBox? box = key.currentContext
                              ?.findRenderObject() as RenderBox?;
                          if (box != null) {
                            final size = box.size;
                            final position = box.localToGlobal(Offset.zero);

                            // Show size and position in a dialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('RenderBox Info'),
                                content: Text(
                                    'Item $index\nSize: $size\nPosition: $position'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditItemScreen(
                onItemAdded: (item) {
                  context.read<ItemProvider>().addItem(item);
                },
              ),
            ),
          );

          // If addition was successful, the provider will handle success message
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
