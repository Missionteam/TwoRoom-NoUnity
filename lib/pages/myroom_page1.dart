// ignore_for_file: unused_import, unused_field, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tworoom/allConstants/all_constants.dart';

import '../models/post.dart';
import '../providers/posts_provider.dart';
import '../widgets/fundomental/post_widget.dart';

class MyRoomPage1 extends ConsumerStatefulWidget {
  MyRoomPage1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<MyRoomPage1> {
  //get onUnityCreated => null;

  Future<void> sendPost(String text) async {
    // まずは user という変数にログイン中のユーザーデータを格納します
    final user = FirebaseAuth.instance.currentUser!;
    final posterId = user.uid; // ログイン中のユーザーのIDがとれます
    final posterName = user.displayName!; // Googleアカウントの名前がとれます
    final posterImageUrl = user.photoURL!; // Googleアカウントのアイコンデータがとれます
    final roomId = 'BWFcU9owLQbdSStahSw4';

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
    final roomId = 'BWFcU9owLQbdSStahSw4';
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
              //UnityWidget(onUnityCreated: onUnityCreated),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 40, left: 40, right: 40, bottom: 20),
              //   child: Text(
              //     currentRoomName,
              //     textAlign: TextAlign.center,
              //     style: GoogleFonts.nunito(
              //         fontWeight: FontWeight.w500,
              //         color: Color.fromARGB(255, 228, 228, 228),
              //         fontSize: 24),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 0, left: 80, right: 80, bottom: 20),
              //   child: Text(
              //     'ふと思いついたことを、なんでもつぶやきましょう。',
              //     textAlign: TextAlign.center,
              //     style: GoogleFonts.nunito(
              //         fontWeight: FontWeight.w500,
              //         color: Color.fromARGB(255, 228, 228, 228),
              //         fontSize: 14),
              //   ),
              // ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Image.asset('images/whatNowStamp/WorkBoy1.png')],
              )
                  // ref.watch(postsProvider(roomId)).when(
                  //   data: (data) {
                  //     /// 値が取得できた場合に呼ばれる。
                  //     return ListView.builder(
                  //       padding: EdgeInsets.only(top: 10, left: 10),
                  //       itemCount: data.docs.length,
                  //       itemBuilder: (context, index) {
                  //         final post = data.docs[index].data();
                  //         return PostWidget(post: post);
                  //       },
                  //     );
                  //   },
                  //   error: (_, __) {
                  //     /// 読み込み中にErrorが発生した場合に呼ばれる。
                  //     return const Center(
                  //       child: Text('不具合が発生しました。'),
                  //     );
                  //   },
                  //   loading: () {
                  //     /// 読み込み中の場合に呼ばれる。
                  //     return const Center(
                  //       child: CircularProgressIndicator(),
                  //     );
                  //   },
                  // ),
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextFormField(
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
                    // 入力中の文字列を削除します。
                    controller.clear();
                  },
                ),
              ),
            ]),
          ]),
        ),
      ),
      // */
    );
  }
}
