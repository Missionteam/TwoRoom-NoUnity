// ignore_for_file: unused_import, unused_field, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tworoom/models/cloud_storage_model.dart';
import 'package:tworoom/providers/talkroom_provider.dart';
import 'package:tworoom/providers/users_provider.dart';
import 'package:tworoom/widgets/fundomental/post_widget1.dart';

import 'package:intl/intl.dart';

import '../models/post.dart';
import '../providers/cloud_messeging_provider.dart';
import '../providers/posts_provider.dart';
import '../widgets/fundomental/post_widget.dart';

class ChatPage1 extends ConsumerStatefulWidget {
  ChatPage1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage1> {
  //get onUnityCreated => null;
  String imageLocalPath = '';
  String imageCloudPath = '';

  Future<void> sendPost(String text) async {
    final userDoc = ref.watch(CurrentAppUserDocProvider).value;
    final posterId = userDoc?.get('id');
    final posterName = userDoc?.get('displayName');
    final posterImageUrl = userDoc?.get('photoUrl');
    final roomId = 'init';
    final imageLocalPath = this.imageLocalPath;
    final String talkroomId = userDoc?.get('talkroomId') ?? '';
    final imageRemotePath =
        '${talkroomId}/${DateFormat('MMddHH:mm:ssSSS').format(Timestamp.now().toDate())}';

    final newDocumentReference = ref.read(postsReferenceProvider).doc();
    if (imageLocalPath != '') {
      uploadFile(imageLocalPath, imageRemotePath);
    }
    final newPost = Post(
      text: text,
      roomId: roomId,
      createdAt: Timestamp.now(), // 投稿日時は現在とします
      posterName: posterName,
      posterImageUrl: posterImageUrl,
      posterId: posterId,
      stamps: '',
      imageLocalPath: imageLocalPath,
      imageUrl: (imageLocalPath != '') ? imageRemotePath : '',
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
    final currentRoomName = '日常会話の部屋';
    final roomId = 'init';
    final token = ref.watch(PartnerfcmTokenProvider).value ?? '';
    final talkroomId = ref.watch(talkroomIdProvider).value;

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
              Column(children: [
                //UnityWidget(onUnityCreated: onUnityCreated),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 40, right: 40, bottom: 15),
                  child: Text(
                    '日常会話の部屋',
                    // currentRoomName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 228, 228, 228),
                        fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 50, right: 50, bottom: 20),
                    child: Text(
                      'LINEの代わりとしてご利用頂けます。\nLINEよりも開封の負荷が少ないのが魅力です。',
                      // 'ここは日常会話の部屋です。LINEの代わりとしてご活用ください。',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 228, 228, 228),
                          fontSize: 14),
                    ),
                  ),
                ),
                Expanded(
                  child: ref.watch(postsProvider(roomId)).when(
                    data: (data) {
                      /// 値が取得できた場合に呼ばれる。
                      return ListView.builder(
                        reverse: true,
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
                      IconButton(
                          onPressed: () async {
                            final localPath = await select_icon(context) ?? '';
                            setState(() {
                              this.imageLocalPath = localPath;
                            });
                          },
                          icon: Icon(Icons.add)),
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
                                    token, '恋人からメッセージです。', '');
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
