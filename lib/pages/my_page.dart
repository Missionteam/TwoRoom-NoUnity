// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tworoom/widgets/specific/setting/linkage_dialog.dart';

import '../providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});
  /*
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  late UnityWidgetController _unityWidgetController;
*/

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final user = ref.read(userProvider).value!;
    final user = ref.watch(authStateProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 250, 250, 250),
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          '個人設定',
          style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 90, 90, 90),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              MenuWidget(
                  icon: Icons.lock_person_outlined,
                  text: 'プライバシー',
                  onpressed: () {}),
              MenuWidget(
                  icon: Icons.notifications_outlined,
                  text: '通知',
                  onpressed: () {}),
              MenuWidget(
                  icon: Icons.chat_bubble_outline,
                  text: 'ヘルプ＆フィードバック',
                  onpressed: () {}),
              MenuWidget(
                  icon: Icons.person_add_rounded,
                  text: 'パートナーと連携する',
                  onpressed: () {
                    showDialog(
                        context: context, builder: (_) => LinkageDialog());
                  }),
              MenuWidget(
                  icon: Icons.info_outline,
                  text: 'ふたりべやについて',
                  onpressed: () {}),
              MenuWidget(
                  icon: Icons.file_download_outlined,
                  text: 'キャッシュデータ',
                  onpressed: () {}),
              MenuWidget(
                icon: Icons.power_settings_new,
                text: 'ログアウト',
                onpressed: () async {
                  // Google からサインアウト
                  print('feel pressed');
                  await GoogleSignIn().signOut();
                  // Firebase からサインアウト
                  await ref.read(fireBaseAuthProvider).signOut();
                },
              ),
            ],
          ),
        ),
      ),

      //UnityWidget(onUnityCreated: onUnityCreated)
    );
  }
  /*void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }
  */
}

class MenuWidget extends StatefulWidget {
  MenuWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.onpressed,
  }) : super(key: key);
  String text;
  IconData icon;
  void Function() onpressed;
  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onpressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.text,
                  style: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 90, 90, 90),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
