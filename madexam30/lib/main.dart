import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/loyalty_card.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the LoyaltyCard adapter
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(LoyaltyCardAdapter());
  }

  // Initialize services
  final storageService = StorageService();
  await storageService.init();

  // Initialize notifications
  NotificationService();

  // Open the loyalty cards box
  await Hive.openBox<LoyaltyCard>('loyaltyCards');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loyalty Cards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
