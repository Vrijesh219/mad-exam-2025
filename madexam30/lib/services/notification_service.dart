import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/loyalty_card.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal() {
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
  }

  Future<void> scheduleExpiryNotification(LoyaltyCard card) async {
    if (card.isExpired) return;

    final daysUntilExpiry = card.daysUntilExpiry;
    if (daysUntilExpiry <= 30) {
      await _notifications.show(
        card.id.hashCode,
        'Card Expiring Soon',
        '${card.title} will expire in $daysUntilExpiry days',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'loyalty_cards',
            'Loyalty Cards',
            channelDescription: 'Notifications for loyalty card expiration',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
      );
    }
  }

  Future<void> checkAllCardsExpiry(List<LoyaltyCard> cards) async {
    for (final card in cards) {
      await scheduleExpiryNotification(card);
    }
  }
}
