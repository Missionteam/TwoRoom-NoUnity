// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tworoom/providers/users_provider.dart';

import '../models/post.dart';
import '../providers/cloud_messeging_provider.dart';
import '../providers/posts_provider.dart';

class ReviewPage extends ConsumerStatefulWidget {
  const ReviewPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> {
  String _review = '';
  final _formKey = GlobalKey<FormState>();
  Future<void> sendPost(String text) async {
    // まずは user という変数にログイン中のユーザーデータを格納します
    final userDoc = ref.watch(CurrentAppUserDocProvider).value;
    final posterId = userDoc?.get('id'); // ログイン中のユーザーのIDがとれます
    final posterName = userDoc?.get('displayName'); // Googleアカウントの名前がとれます
    final posterImageUrl = userDoc?.get('photoUrl'); // Googleアカウントのアイコンデータがとれます
    final roomId = 'rivew';

    // 先ほど作った postsReference からランダムなIDのドキュメントリファレンスを作成します
    // doc の引数を空にするとランダムなIDが採番されます
    final newDocumentReference = ref.read(postsReferenceProvider).doc();

    final newPost = Post(
      text: text,
      roomId: roomId,
      createdAt: Timestamp.now(), // 投稿日時は現在とします
      posterName: posterName,
      posterImageUrl: posterImageUrl,
      posterId: posterId,
      stamps: '',
      reference: newDocumentReference,
    );

    // 先ほど作った newDocumentReference のset関数を実行するとそのドキュメントにデータが保存されます。
    // 引数として Post インスタンスを渡します。
    // 通常は Map しか受け付けませんが、withConverter を使用したことにより Post インスタンスを受け取れるようになります。
    newDocumentReference.set(newPost);
  }

  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Color.fromARGB(255, 255, 173, 173),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 250, 250, 250),
        toolbarHeight: 100,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            'アプリのフィードバックをする',
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 90, 90, 90),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Image.asset('images/whatNowStamp/Tworoom.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Text(
                    'このアプリは、大学生が制作したアプリです。\n私たちは、カップルの方々が「もっと恋人と繋がれる」ようなアプリを作りたいと考えていますが、まだまだ課題点が多いと感じています。皆さんがどのようなことを感じているのか、ぜひ私たちに聞かせて頂けませんか？'),
              ),
              Form(
                  key: _formKey,
                  child: Container(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 40, right: 0, bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: new TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: controller,
                              enabled: true,
                              obscureText: false,
                              decoration: const InputDecoration(
                                hintText: 'このアプリの感想を教えてください',
                                labelText: '感想',
                              ),
                              onSaved: (String? value) {
                                this._review = value ?? '';
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                sendPost(controller.text);
                                primaryFocus?.unfocus();
                                FirebaseCloudMessagingService()
                                    .sendPushNotification(
                                        'f4HpmEBqQ-qGPuBdidWX6U:APA91bGiRcZPzf4-UQ6lJ5zVFlNbySo5gh0k_ySs2ChN6S45Pj4uMqlj-lb7znbzXoeRKwu3p-m0nCNET6DPutHp-nhQ-YihrqKhdKycgKa2d0HBY9PP4x6JksW9E73gvOj7bUkE863N',
                                        '利用者の方からFBが届きました。',
                                        '');
                                controller.clear();
                              },
                              icon: Icon(Icons.send))
                        ],
                      ))),
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
