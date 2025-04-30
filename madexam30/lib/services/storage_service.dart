import 'package:hive_flutter/hive_flutter.dart';
import '../models/loyalty_card.dart';

class StorageService {
  static const String _boxName = 'loyaltyCards';
  late Box<LoyaltyCard> _box;
  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  Future<void> init() async {
    _box = await Hive.openBox<LoyaltyCard>(_boxName);
  }

  Future<void> addCard(LoyaltyCard card) async {
    await _box.add(card);
  }

  Future<void> deleteCard(LoyaltyCard card) async {
    await card.delete();
  }

  List<LoyaltyCard> getAllCards() {
    return _box.values.toList();
  }

  List<LoyaltyCard> getExpiringCards({int withinDays = 30}) {
    final now = DateTime.now();
    return _box.values.where((card) {
      final daysUntilExpiry = card.expiryDate.difference(now).inDays;
      return daysUntilExpiry >= 0 && daysUntilExpiry <= withinDays;
    }).toList();
  }

  Stream<List<LoyaltyCard>> watchCards() {
    return _box.watch().map((_) => getAllCards());
  }

  Future<void> close() async {
    await _box.close();
  }
}
