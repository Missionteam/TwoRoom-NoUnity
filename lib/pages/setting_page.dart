// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tworoom/providers/users_provider.dart';
import 'package:tworoom/widgets/specific/setting/linkage_dialog.dart';
import 'package:tworoom/widgets/specific/setting/profile_setting_dialog.dart';

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
    final currentUserDoc = ref.watch(CurrentAppUserDocProvider).value;
    final partnerUserDoc = ref.watch(partnerUserDocProvider).value;
    final String currentUserImageName =
        currentUserDoc?.get('photoUrl') ?? 'Girl';
    final String currentUserName =
        currentUserDoc?.get('displayName') ?? 'お名前を登録してください。';
    final String partnerUserName =
        partnerUserDoc?.get('displayName') ?? 'お名前が登録されていません。';

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () => GoRouter.of(context).pop(),
                icon: Icon(
                  Icons.chevron_left_outlined,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
          ],
        ),
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
                height: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 3, bottom: 20),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      content: Text(
                                          '申し訳ございません。現在写真のアップロード機能は開発途中となっております。'),
                                    ));
                          },
                          child: CircleAvatar(
                              radius: 60,
                              foregroundImage: AssetImage(
                                  'images/${currentUserImageName}Icon.png')),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            currentUserName,
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '  好きな人：${partnerUserName}',
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                          onTap: () => showDialog(
                              context: context,
                              builder: (_) => MyProfileSettingPage()),
                          child: Container(
                            height: 37,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 238, 238, 238),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.border_color_rounded,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '編集',
                                  style: GoogleFonts.nunito(fontSize: 15),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              /*  */
              // MenuWidget(
              //     icon: Icons.lock_person_outlined,
              //     text: 'プライバシー',
              //     onpressed: () {}),

              // /*  */
              // MenuWidget(
              //     icon: Icons.chat_bubble_outline,
              //     text: 'ヘルプ＆フィードバック',
              //     onpressed: () {}),
              MenuWidget(
                  icon: Icons.person_add_rounded,
                  text: 'パートナーと連携する',
                  onpressed: () {
                    showDialog(
                        context: context, builder: (_) => LinkageDialog());
                  }),
              // MenuWidget(
              //     icon: Icons.info_outline,
              //     text: 'ふたりべやについて',
              //     onpressed: () {}),
              MenuWidget(
                icon: Icons.power_settings_new,
                text: 'ログアウト',
                onpressed: () async {
                  // Google からサインアウト
                  print('feel pressed');
                  await FirebaseAuth.instance.signOut();
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
