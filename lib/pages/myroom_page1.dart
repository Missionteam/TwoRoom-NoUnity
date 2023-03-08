// ignore_for_file: unused_import, unused_field, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:tworoom/allConstants/all_constants.dart';
import 'package:tworoom/pages/chat_room_page1.dart';

import '../models/post.dart';
import '../providers/cloud_messeging_provider.dart';
import '../providers/posts_provider.dart';
import '../providers/users_provider.dart';
import '../widgets/fundomental/post_widget.dart';
import '../widgets/specific/Tweet/tweet_widget.dart';

class MyRoomPage1 extends ConsumerStatefulWidget {
  MyRoomPage1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<MyRoomPage1> {
  //get onUnityCreated => null;

  Future<void> sendPost(String text) async {
    // まずは user という変数にログイン中のユーザーデータを格納します
    final userDoc = ref.watch(CurrentAppUserDocProvider).value;
    final posterId = userDoc?.get('id'); // ログイン中のユーザーのIDがとれます
    final posterName = userDoc?.get('displayName'); // Googleアカウントの名前がとれます
    final posterImageUrl = userDoc?.get('photoUrl');
    final roomId = 'tweet';

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

  // build の外でインスタンスを作ります。
  final controller = TextEditingController();

  /// この dispose 関数はこのWidgetが使われなくなったときに実行されます。
  @override
  void dispose() {
    // TextEditingController は使われなくなったら必ず dispose する必要があります。
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentRoomName = 'ひとりごと';
    final roomId = 'tweet';
    final isGirl = ref.watch(isGirlProvider);
    final imageName = (isGirl == true) ? 'Girl' : 'Boy';
    final token = ref.watch(PartnerfcmTokenProvider).value ?? '';

    return GestureDetector(
      onTap: () {
        primaryFocus?.unfocus();
      },

      child: Scaffold(
        body: Container(
          color: AppColors.main,
          child: Stack(children: [
            // Positioned(
            //   child: Image.asset('images/chat/chatHeader.png'),
            // ),

            Column(children: [
              Expanded(
                  child: ref.watch(postsReverseProvider(roomId)).when(
                data: (data) {
                  /// 値が取得できた場合に呼ばれる。
                  return ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 10, left: 10),
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      final post = data.docs[index].data();
                      return TweetWidget(post: post);
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
              )),
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60),
                child:
                    Image.asset('images/whatNowStamp/Work${imageName}Icon.png'),
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
                          controller.clear();
                          primaryFocus?.unfocus();
                          FirebaseCloudMessagingService().sendPushNotification(
                              token, 'パートナーからメッセージです。', controller.text);
                        },
                        icon: Icon(Icons.send))
                  ],
                ),
              ),
            ]),
            Positioned(
                top: 20,
                left: 30,
                child: HelpBotton(
                  title: 'つぶやきルームの使い方',
                  text: '',
                )),
          ]),
        ),
      ),
      // */
    );
  }
}
