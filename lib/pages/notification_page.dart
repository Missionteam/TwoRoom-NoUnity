import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tworoom/pages/auth/auth_checker.dart';
import 'package:tworoom/providers/cloud_messeging_provider.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  String _token = "";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // アプリ初期化時に画面にtokenを表示
    _firebaseMessaging.getToken().then((String? token) {
      setState(() {
        _token = token!;
      });
      // コピーしやすいようにターミナルに出すためにprint
      print(token);
    });

    FirebaseCloudMessagingService().iOSForegroundNotification();

    //フォアグラウンドでメッセージを受け取った時のイベント
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      FirebaseCloudMessagingService().locaknotify(
          notification.hashCode, notification?.title, notification?.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthChecker();
  }
}
