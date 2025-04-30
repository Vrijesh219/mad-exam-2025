import 'package:flutter/material.dart';
import '../models/loyalty_card.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';
import 'add_card_screen.dart';
import 'card_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StorageService _storageService = StorageService();
  final NotificationService _notificationService = NotificationService();
  List<LoyaltyCard> _expiringCards = [];

  @override
  void initState() {
    super.initState();
    _loadExpiringCards();
  }

  Future<void> _loadExpiringCards() async {
    final expiringCards = _storageService.getExpiringCards();
    setState(() {
      _expiringCards = expiringCards;
    });
    await _notificationService.checkAllCardsExpiry(expiringCards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Loyalty Cards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCardScreen()),
              );
              _loadExpiringCards();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_expiringCards.isNotEmpty)
            Container(
              color: Colors.orange.shade100,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cards Expiring Soon',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _expiringCards.length,
                      itemBuilder: (context, index) {
                        final card = _expiringCards[index];
                        return Card(
                          margin: const EdgeInsets.only(right: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  card.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('${card.daysUntilExpiry} days left'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: StreamBuilder<List<LoyaltyCard>>(
              stream: _storageService.watchCards(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final cards = snapshot.data!;
                if (cards.isEmpty) {
                  return const Center(
                    child: Text('No loyalty cards yet. Tap + to add one!'),
                  );
                }

                return ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text(card.title),
                        subtitle: Text(
                          'Expires: ${card.expiryDate.toString().split(' ')[0]}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (card.isExpired)
                              const Icon(Icons.warning, color: Colors.red),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CardDetailScreen(card: card),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCardScreen()),
          );
          _loadExpiringCards();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
