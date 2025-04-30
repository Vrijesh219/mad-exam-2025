import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/loyalty_card.dart';
import '../services/storage_service.dart';

class CardDetailScreen extends StatelessWidget {
  final LoyaltyCard card;
  final StorageService _storageService = StorageService();

  CardDetailScreen({super.key, required this.card});

  Future<void> _deleteCard(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Card'),
            content: Text('Are you sure you want to delete ${card.title}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirmed == true && context.mounted) {
      await _storageService.deleteCard(card);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteCard(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      card.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Card Number: ${card.cardNumber}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Expires: ${card.expiryDate.toString().split(' ')[0]}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (card.isExpired)
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'This card has expired',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    else if (card.daysUntilExpiry <= 30)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Expires in ${card.daysUntilExpiry} days',
                          style: const TextStyle(color: Colors.orange),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            QrImageView(
              data: card.barcodeData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 16),
            Text(
              'Scan this QR code',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement share functionality
              },
              icon: const Icon(Icons.share),
              label: const Text('Share Card'),
            ),
          ],
        ),
      ),
    );
  }
}
