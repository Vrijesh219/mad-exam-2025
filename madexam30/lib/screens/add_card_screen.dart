import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/loyalty_card.dart';
import '../services/storage_service.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _barcodeDataController = TextEditingController();
  final _storageService = StorageService();
  DateTime _expiryDate = DateTime.now().add(const Duration(days: 365));

  @override
  void dispose() {
    _titleController.dispose();
    _cardNumberController.dispose();
    _barcodeDataController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  Future<void> _saveCard() async {
    if (_formKey.currentState!.validate()) {
      final card = LoyaltyCard(
        id: const Uuid().v4(),
        title: _titleController.text,
        cardNumber: _cardNumberController.text,
        barcodeData: _barcodeDataController.text,
        expiryDate: _expiryDate,
      );

      await _storageService.addCard(card);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Loyalty Card')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Card Title',
                  hintText: 'e.g., Starbucks Rewards',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  hintText: 'Enter your card number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _barcodeDataController,
                decoration: const InputDecoration(
                  labelText: 'Barcode Data',
                  hintText: 'Enter barcode data or scan',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter barcode data';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Expiry Date'),
                subtitle: Text(_expiryDate.toString().split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveCard,
                child: const Text('Save Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
