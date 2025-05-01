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
## ScreenSHot:
![image](https://github.com/user-attachments/assets/575d8a89-e45b-420e-8d85-9a0db804e569)

![image](https://github.com/user-attachments/assets/127e62c6-9706-41d1-b0b4-9d4ffc8ff574)
![image](https://github.com/user-attachments/assets/2463a48c-3d82-48e2-ad97-ec735290c4e1)
![image](https://github.com/user-attachments/assets/ad332858-4b00-4d61-9081-fe68ac1ef6d5)
![image](https://github.com/user-attachments/assets/db5db8e8-d642-4530-83d6-f6673c3e6bbe)
![image](https://github.com/user-attachments/assets/833cbae5-0e27-4ffb-aaef-b3deee4ef701)
![image](https://github.com/user-attachments/assets/2dc75620-d42c-426f-ad9f-680d3e7944c4)
![image](https://github.com/user-attachments/assets/d224fa80-a3ef-4e86-b374-44ac82adc5d6)
![image](https://github.com/user-attachments/assets/65d433cf-2e0f-4f05-9f4b-ad12fad65965)
![image](https://github.com/user-attachments/assets/e3715952-f371-4c43-8a0b-d6c77c3d5eb9)


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
