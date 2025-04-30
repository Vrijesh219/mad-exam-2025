import 'package:hive/hive.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

part 'loyalty_card.g.dart';

@HiveType(typeId: 0)
class LoyaltyCard extends HiveObject {
  static final _key = encrypt.Key.fromLength(32);
  static final _iv = encrypt.IV.fromLength(16);
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String encryptedCardNumber;

  @HiveField(3)
  final String barcodeData;

  @HiveField(4)
  final DateTime expiryDate;

  LoyaltyCard._internal({
    required this.id,
    required this.title,
    required this.encryptedCardNumber,
    required this.barcodeData,
    required this.expiryDate,
  });

  factory LoyaltyCard({
    required String id,
    required String title,
    required String cardNumber,
    required String barcodeData,
    required DateTime expiryDate,
  }) {
    final encryptedCardNumber = _encrypter.encrypt(cardNumber, iv: _iv).base64;
    return LoyaltyCard._internal(
      id: id,
      title: title,
      encryptedCardNumber: encryptedCardNumber,
      barcodeData: barcodeData,
      expiryDate: expiryDate,
    );
  }

  String get cardNumber {
    return _encrypter.decrypt64(encryptedCardNumber, iv: _iv);
  }

  bool get isExpired {
    return DateTime.now().isAfter(expiryDate);
  }

  int get daysUntilExpiry {
    return expiryDate.difference(DateTime.now()).inDays;
  }

  @override
  String toString() {
    return 'LoyaltyCard(id: $id, title: $title, barcodeData: $barcodeData, expiryDate: $expiryDate)';
  }
}
