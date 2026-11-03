import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:meer_flutter/presentation/favorites/view/favorites_view.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  Future<void> _confirmClear(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('إفراغ المفضلة'),
        content: const Text(
          'هل تريد إزالة جميع المنتجات من المفضلة؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('إفراغ'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<FavoritesBloc>().add(
        const FavoritesEvent.cleared(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listenWhen: (previous, current) =>
          previous.message != current.message && current.message != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(state.message!)),
          );

        context.read<FavoritesBloc>().add(
          const FavoritesEvent.messageCleared(),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'المفضلة',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              if (!state.isEmpty)
                IconButton(
                  tooltip: 'إفراغ المفضلة',
                  onPressed: () => _confirmClear(context),
                  icon: const Icon(Icons.delete_sweep_outlined),
                ),
            ],
          ),
          body: FavoritesView(
            products: state.products,
          ),
        );
      },
    );
  }
}
