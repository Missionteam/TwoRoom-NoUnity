import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tworoom/main.dart';
import 'package:tworoom/pages/auth/mail_signin.dart';

import '../../providers/auth_provider.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

class AuthChecker2 extends ConsumerWidget {
  const AuthChecker2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  now the build method takes a new paramaeter ScopeReader.
    //  this object will be used to access the provider.

    //  now the following variable contains an asyncValue so now we can use .when method
    //  to imply the condition
    ///ここの分岐はauthの方消して良いはずだけど、デバック時に確かめる。
    final authState = ref.watch(authStateProvider);
    return authState.when(
        data: (data) {
          if (data != null) {
            return const MyApp();
          }
          return MailSignInPage();
        },
        loading: () => const LoadingScreen(),
        error: (e, trace) => ErrorScreen(e, trace));
  }
}
