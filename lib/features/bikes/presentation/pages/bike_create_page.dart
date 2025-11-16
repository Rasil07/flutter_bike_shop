import 'package:bike_shop_2/features/bikes/view_model/create_bike_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BikeCreatePage extends StatefulWidget {
  const BikeCreatePage({super.key});

  @override
  State<BikeCreatePage> createState() => _BikeCreatePageState();
}

class _BikeCreatePageState extends State<BikeCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _modelController = TextEditingController();
  final _brandController = TextEditingController();
  final _priceController = TextEditingController();

  final _imagePicker = ImagePicker();

  @override
  void dispose() {
    _modelController.dispose();
    _brandController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
    );

    if (picked == null) return;

    final bytes = await picked.readAsBytes();

    if (!mounted) return;

    context.read<BikeCreateViewModel>().setImage(bytes, picked.name);
  }

  Future<void> _removeImage() async {
    context.read<BikeCreateViewModel>().clearImage();
  }

  Future<void> _submit() async {
    final vm = context.read<BikeCreateViewModel>();

    if (!_formKey.currentState!.validate()) return;

    final priceText = _priceController.text.trim();
    final price = double.tryParse(priceText);
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Price must be a valid number')),
      );
      return;
    }

    final success = await vm.submit(
      model: _modelController.text.trim(),
      brand: _brandController.text.trim(),
      price: price,
    );

    if (!mounted) return;

    if (success) {
      // go_router pop
      context.pop();
    } else if (vm.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(vm.errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BikeCreateViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Bike')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // IMAGE PREVIEW + PICK/REMOVE BUTTONS
              _ImageSelector(
                vm: vm,
                onPickImage: _pickImage,
                onRemoveImage: _removeImage,
              ),

              const SizedBox(height: 16),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _modelController,
                      decoration: const InputDecoration(
                        labelText: 'Model name',
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a model name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _brandController,
                      decoration: const InputDecoration(
                        labelText: 'Brand',
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a brand';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        border: OutlineInputBorder(),
                        prefixText: '\$',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value.trim()) == null) {
                          return 'Enter a valid number';
                        }
                        if (double.parse(value.trim()) < 0) {
                          return 'Price cannot be negative';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    if (vm.errorMessage != null) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          vm.errorMessage!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: vm.isSubmitting ? null : _submit,
                        child: vm.isSubmitting
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Create Bike'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageSelector extends StatelessWidget {
  final BikeCreateViewModel vm;
  final Future<void> Function() onPickImage;
  final Future<void> Function() onRemoveImage;

  const _ImageSelector({
    required this.vm,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant),
            color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
          ),
          clipBehavior: Clip.antiAlias,
          child: vm.imageBytes != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.memory(vm.imageBytes!, fit: BoxFit.cover),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton.filledTonal(
                        icon: const Icon(Icons.close),
                        onPressed: () => onRemoveImage(),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        size: 36,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No image selected',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: vm.isSubmitting ? null : onPickImage,
            icon: const Icon(Icons.add_a_photo_outlined),
            label: Text(vm.imageBytes == null ? 'Add image' : 'Change image'),
          ),
        ),
      ],
    );
  }
}
