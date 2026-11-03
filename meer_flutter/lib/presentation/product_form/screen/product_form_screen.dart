import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/presentation/product_form/bloc/product_form_bloc.dart';
import 'package:meer_flutter/presentation/product_form/view/product_form_view.dart';

class ProductFormScreen extends StatelessWidget {
  const ProductFormScreen({
    super.key,
    this.productToEdit,
  });

  final Product? productToEdit;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductFormBloc, ProductFormState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) {
            Navigator.of(context).pop(true);
          },
          failure: (message) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
          },
        );
      },
      builder: (context, state) {
        final isSubmitting = state.maybeWhen(
          submitting: () => true,
          orElse: () => false,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(
              productToEdit == null ? 'إضافة منتج' : 'تعديل منتج',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            child: ProductFormView(
              initialProduct: productToEdit,
              isSubmitting: isSubmitting,
              onSubmit:
                  ({
                    required name,
                    required price,
                    description,
                    imageUrl,
                  }) {
                    context.read<ProductFormBloc>().add(
                      ProductFormEvent.submitted(
                        name: name,
                        price: price,
                        description: description,
                        imageUrl: imageUrl,
                      ),
                    );
                  },
            ),
          ),
        );
      },
    );
  }
}
