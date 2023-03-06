import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tworoom/pages/auth/register.dart';
import 'package:tworoom/providers/cloud_messeging_provider.dart';

import '../../models/auth_model.dart';

class MailSignInPage extends ConsumerStatefulWidget {
  const MailSignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MailSignInPageState();
}

class _MailSignInPageState extends ConsumerState<MailSignInPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 20),
                      child: CircleAvatar(
                          radius: 60,
                          foregroundImage: AssetImage('images/GirlIcon.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 20),
                      child: CircleAvatar(
                          radius: 60,
                          foregroundImage: AssetImage('images/BoyIcon.png')),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'ふたりべやを始めましょう！',
                  style: GoogleFonts.nunito(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'メールアドレス'),
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                // 2行目 パスワード入力用テキストフィールド
                TextFormField(
                  decoration: const InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // 3行目 ユーザ登録ボタン
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: const Text('ユーザ登録'),
                        onPressed: () async {
                          try {
                            await auth.signInWithMail(context, email, password);
                            FirebaseCloudMessagingService().fcmGetToken();
                            // Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return RegisterPage();
                            }));
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: const Text('ログイン'),
                        onPressed: () async {
                          try {
                            // メール/パスワードでログイン
                            final User? user = (await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email, password: password))
                                .user;
                            if (user != null)
                              print("ログインしました　${user.email} , ${user.uid}");
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                // 4行目 ログインボタン

                // 5行目 パスワードリセット登録ボタン
                MaterialButton(
                    child: const Text('パスワードリセット'),
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email);
                        print("パスワードリセット用のメールを送信しました");
                      } catch (e) {
                        print(e);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
