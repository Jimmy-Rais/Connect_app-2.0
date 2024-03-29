import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessages(RemoteMessage message) async {}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print('token: $fcmToken');
    print('token: $fcmToken');
    print('token: $fcmToken');
    print('token: $fcmToken');
    print('token: $fcmToken');
    print('token: $fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);
  }
}
