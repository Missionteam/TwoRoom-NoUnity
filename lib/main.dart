import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:tworoom/pages/chat_page1.dart';
import 'package:tworoom/pages/chat_room_page1.dart';
import 'package:tworoom/pages/home_page1.dart';
import 'package:tworoom/pages/home_page11.dart';
import 'package:tworoom/pages/myroom_page1.dart';
import 'package:tworoom/pages/notification_page.dart';
import 'package:tworoom/widgets/fundomental/BtmNavigation1.dart';
import 'package:tworoom/widgets/fundomental/BtmNavigation2.dart';

import 'firebase_options.dart';
import 'pages/auth/auth_checker.dart';
import 'pages/chat_room_page.dart';
import 'pages/home_page.dart';
import 'pages/setting_page.dart';
import 'pages/myroom_page.dart';
import 'pages/room_grid_page.dart';
import 'pages/room_page2.dart';

//      home: const SignInPage(),
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

/// プラットフォームの確認
final isAndroid =
    defaultTargetPlatform == TargetPlatform.android ? true : false;
final isIOS = defaultTargetPlatform == TargetPlatform.iOS ? true : false;

/// FCMバックグランドメッセージの設定
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

Future<void> main() async {
  // main 関数でも async が使えます
  WidgetsFlutterBinding.ensureInitialized();
  // runApp 前に何かを実行したいときはこれが必要です。
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    // これが Firebase の初期化処理です。
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(child: InitPage()),
  );
}

class InitPage extends ConsumerWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(home: AuthChecker());
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/Home1',
    routes: <RouteBase>[
      /// Application shell
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return (1 == 1)
              ? ScaffoldWithNavBar1(child: child)
              : ScaffoldWithNavBar2(child: child);
        },
        routes: <RouteBase>[
          /// The first screen to display in the bottom navigation bar
          GoRoute(
              path: '/NotificationPage',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(child: NotificationPage());
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'Auth_checker',
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      NoTransitionPage(
                    child: const AuthChecker(),
                  ),
                ),
              ]),

          /// Displayed when the second item in the the bottom navigation bar is
          /// selected.
          GoRoute(
            path: '/Home',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: const HomePage());
            },
          ),

          /// The third screen to display in the bottom navigation bar.
          GoRoute(
            path: '/Chat',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: ChatPage1());
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'Rooms',
                builder: (BuildContext context, GoRouterState state) {
                  return const RoomPage();
                },
              ),
              // GoRoute(
              //     path: 'Reply/:post',
              //     builder: ((context, state) {
              //       return ReplyPage(post: state.params['post']);
              //     })),
            ],
          ),
          GoRoute(
            path: '/RoomGrid',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: RoomGridPage());
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'Chat',
                builder: (BuildContext context, GoRouterState state) {
                  return ChatRoomPage();
                },
              ),
              GoRoute(
                path: 'AddRoom',
                builder: (BuildContext context, GoRouterState state) {
                  return RoomPage();
                },
              ),
            ],
          ),
          GoRoute(
            path: '/MyRoom',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: MyRoomPage());
            },
          ),
          GoRoute(
            path: '/Setting',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: ProfilePage());
            },
          ),
          GoRoute(
              path: '/Home1',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return NoTransitionPage(child: const HomePage1());
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'Chat1',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return NoTransitionPage(child: ChatPage1());
                  },
                ),
                GoRoute(
                  path: 'Home11',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return NoTransitionPage(child: HomePage11());
                  },
                ),
                GoRoute(
                  path: 'Setting',
                  pageBuilder: (context, state) {
                    return NoTransitionPage(child: ProfilePage());
                  },
                ),
              ]),

          /// The third screen to display in the bottom navigation bar.
          GoRoute(
            path: '/Chat1',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: ChatPage1());
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'Rooms',
                builder: (BuildContext context, GoRouterState state) {
                  return const RoomPage();
                },
              ),
              // GoRoute(
              //     path: 'Reply/:post',
              //     builder: ((context, state) {
              //       return ReplyPage(post: state.params['post']);
              //     })),
            ],
          ),
          GoRoute(
            path: '/RoomGrid1',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: RoomGridPage());
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'Chat1',
                builder: (BuildContext context, GoRouterState state) {
                  return ChatRoomPage1();
                },
              ),
              GoRoute(
                path: 'AddRoom',
                builder: (BuildContext context, GoRouterState state) {
                  return RoomPage();
                },
              ),
            ],
          ),
          GoRoute(
            path: '/MyRoom1',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: MyRoomPage1());
            },
          ),
        ],
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(),
      // home: const SignInPage(),
      // home: const AuthChecker(),
      routerConfig: _router,
      // routes: <String, WidgetBuilder>{
      //   '/home': (BuildContext context) => new MainPage(),
      //   '/testPage': (BuildContext context) => new TestPage()
      // },
    );

    //   元々のAuth＿cheker
    //   if (FirebaseAuth.instance.currentUser == null) {
    //    // 未ログイン
    //    return MaterialApp(
    //      theme: ThemeData(),
    //      home: const SignInPage(),
    //    );
    //  } else {
    //    // ログイン中
    //    return MaterialApp(
    //      theme: ThemeData(),
    //      home: const MainPage(),
    //    );
    //  }
  }
}
