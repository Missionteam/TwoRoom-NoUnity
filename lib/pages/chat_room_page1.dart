// ignore_for_file: unused_import, unused_field, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tworoom/models/room_id_model.dart';
import 'package:tworoom/providers/cloud_messeging_provider.dart';
import 'package:tworoom/widgets/fundomental/post_widget1.dart';

import '../models/post.dart';
import '../providers/posts_provider.dart';
import '../providers/rooms_provider.dart';
import '../providers/users_provider.dart';
import '../widgets/fundomental/post_widget.dart';

class ChatRoomPage1 extends ConsumerStatefulWidget {
  ChatRoomPage1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatRoomPage1> {
  //get onUnityCreated => null;

  Future<void> sendPost(String text) async {
    // まずは user という変数にログイン中のユーザーデータを格納します
    final userDoc = ref.watch(CurrentAppUserDocProvider).value;
    final posterId = userDoc?.get('id'); // ログイン中のユーザーのIDがとれます
    final posterName = userDoc?.get('displayName'); // Googleアカウントの名前がとれます
    final posterImageUrl = userDoc?.get('photoUrl'); //Googleアカウントのアイコンデータがとれます
    final roomId = ref.watch(roomIdProvider).id;

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
    final currentRoomName = ref.watch(currentRoomNameProvider).value ?? '';
    final roomId = ref.watch(roomIdProvider).id;
    final currentRoomDescription =
        ref.watch(currentRoomDescriptionProvider).value ?? '';
    final token = ref.watch(PartnerfcmTokenProvider).value ?? '';
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            color: Color.fromARGB(255, 248, 231, 229),
            child: Stack(children: [
              Positioned(
                  child: Container(
                height: 140,
                color: Color.fromARGB(255, 241, 141, 141),
              )),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/chat/chatHeader1.png'),
                ),
              ),
              Positioned(
                  left: 8,
                  top: 34,
                  child: IconButton(
                      // onPressed: () => GoRouter.of(context).pop(),
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.chevron_left_outlined,
                        color: Colors.white,
                        size: 20,
                      ))),
              Positioned(
                right: 20,
                top: 35,
                child: (roomId == 'tweet')
                    ? HelpBotton(
                        color: Color.fromARGB(179, 255, 255, 255),
                        title: 'この部屋の使い方',
                        text:
                            'こちらのページでは、二人のつぶやきを見ることができます。\nまた、画面下の４つ目のアイコンからもつぶやくことができますが、そちらのページは、自分のつぶやきのみが表示されます。',
                      )
                    : SizedBox(
                        width: 0,
                      ),
              ),
              Column(children: [
                //UnityWidget(onUnityCreated: onUnityCreated),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 40, right: 40, bottom: 15),
                  child: Text(
                    currentRoomName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 228, 228, 228),
                        fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: 85,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 50, right: 50, bottom: 20),
                    child: Text(
                      currentRoomDescription,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 228, 228, 228),
                          fontSize: 13),
                    ),
                  ),
                ),
                Expanded(
                  child: ref.watch(postsProvider(roomId)).when(
                    data: (data) {
                      /// 値が取得できた場合に呼ばれる。
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          final post = data.docs[index].data();
                          return PostWidget1(post: post);
                        },
                      );
                    },
                    error: (_, __) {
                      /// 読み込み中にErrorが発生した場合に呼ばれる。
                      return const Center(
                        child: Text('不具合が発生しました。'),
                      );
                    },
                    loading: () {
                      /// 読み込み中の場合に呼ばれる。
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: controller,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(47, 165, 165, 165),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(110, 206, 206, 206),
                                width: 1,
                              ),
                            ),
                          ),
                          onFieldSubmitted: (text) {
                            sendPost(text);
                            controller.clear();
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            sendPost(controller.text);

                            primaryFocus?.unfocus();
                            FirebaseCloudMessagingService()
                                .sendPushNotification(
                                    token, 'パートナーからメッセージです。', '');
                            controller.clear();
                          },
                          icon: Icon(Icons.send))
                    ],
                  ),
                ),
              ]),
            ]),
          ),
        ),
        // */
      ),
    );
  }
}

class HelpBotton extends StatelessWidget {
  HelpBotton({
    Key? key,
    required this.text,
    required this.title,
    this.color = const Color.fromARGB(162, 186, 186, 186),
  }) : super(key: key);
  String text;
  String title;
  Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Container(
                    padding: const EdgeInsets.only(bottom: 0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: Color.fromARGB(255, 241, 141, 141),
                        ),
                      ),
                    ),
                    child: Text(
                      title,
                      style: GoogleFonts.nunito(),
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 8, right: 8, bottom: 30),
                    child: Text(
                      text,
                      style: GoogleFonts.notoSans(),
                    ),
                  ),
                ));
      },
      child: Icon(
        Icons.help_rounded,
        color: color,
      ),
    );
  }
}

class RoomDescriptionPage extends ConsumerWidget {
  const RoomDescriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: Text(
          'こちらのページでは、二人のつぶやきを見ることができます。\nまた、画面下の４つ目のアイコンからもつぶやくことができますが、そちらのページは、自分のつぶやきのみが表示されます。'),
    );
  }
}
