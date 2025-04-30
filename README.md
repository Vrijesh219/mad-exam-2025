# 🎟️ Loyalty Card Storage App (Flutter)

A Flutter-based Loyalty Card Storage App for digitizing, managing, and redeeming physical loyalty cards. The app enhances user experience by simplifying card access, enabling barcode/QR display, sending reminders, and syncing data securely with the cloud.

---

## 📌 Problem Statement

Customers often juggle dozens of physical loyalty cards, leading to:

- Wallet clutter and forgotten cards
- Delays at checkout while locating cards
- Missed rewards due to expired or unused cards
- Lack of offline access in places with poor connectivity

---

## 🚀 Solution

The Loyalty Card Storage App provides:

✅ Digital card storage (manual or scan)  
✅ Barcode/QR code display for in-store redemption  
✅ Push notifications for upcoming expiration or offers  
✅ Offline access with local caching (Hive)  
✅ Cloud sync with Firebase Firestore  
✅ Encrypted data storage for security  
✅ Modern UI with intuitive UX in light mode  

---

## 🛠️ Features

- Add cards via scanning or manual entry
- Store and retrieve loyalty cards offline
- Show QR/barcodes on demand
- Push notifications using Firebase Messaging
- Data sync with Firestore when online
- Local persistence with Hive
- Card encryption using flutter_secure_storage
- Connectivity-aware sync logic
- Light-mode friendly UI with Provider state management

---

## 📱 Screens Included

1. Splash Screen  
2. Login (Google/Facebook via Firebase Auth)  
3. Home (List of saved cards)  
4. Add Card (Scan or manual entry)  
5. Card Detail (Barcode/QR + expiry info)  
6. Notification Center  
7. Settings & Sync Status  

---

## 🧰 Tech Stack

| Layer               | Technology            |
|--------------------|------------------------|
| UI & Framework     | Flutter (Dart)         |
| State Management   | Provider               |
| Local Storage      | Hive + Secure Storage  |
| Cloud Backend      | Firebase Firestore     |
| Notifications      | Firebase Messaging     |
| Barcode/QR Display | `barcode_widget`, `qr_flutter` |
| Image Handling     | `image_picker`         |
| Connectivity       | `connectivity_plus`    |

---

## 🔐 Security

- Card numbers and personal data are encrypted locally
- All Firebase and HTTP communications are over HTTPS
- Optionally extendable to include biometric login (face/fingerprint)

---

## 🧪 Future Enhancements

- AI card suggestions based on user location
- Reward tracking dashboard
- Merchant integration for real-time offers
- Multi-device sync
- OCR card scanning

---

## 🧳 Getting Started

```bash
cd loyalty_card_app
flutter pub get
flutter run
