// ignore_for_file: unused_import, unused_field, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/post.dart';
import '../providers/posts_provider.dart';
import '../widgets/fundomental/post_widget.dart';

class ChatPage extends ConsumerStatefulWidget {
  ChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  //get onUnityCreated => null;

  Future<void> sendPost(String text) async {
    // まずは user という変数にログイン中のユーザーデータを格納します
    final user = FirebaseAuth.instance.currentUser!;
    final posterId = user.uid; // ログイン中のユーザーのIDがとれます
    final posterName = user.displayName!; // Googleアカウントの名前がとれます
    final posterImageUrl = user.photoURL!; // Googleアカウントのアイコンデータがとれます
    final roomId = 'init';

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
    final currentRoomName = '日常会話の部屋';
    final roomId = 'init';
    return GestureDetector(
      onTap: () {
        primaryFocus?.unfocus();
      },

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: Text(currentRoomName ?? '',
        //       style: TextStyle(color: Colors.black)),
        //   backgroundColor: Colors.white,
        //   elevation: 1,
        //   leading: SizedBox(
        //     width: 30,
        //   ),
        //   // IconButton(
        //   //   onPressed: () {
        //   //     return context.go('/Chat/Rooms');
        //   //   },
        //   //   icon: Icon(
        //   //     Icons.chevron_left,
        //   //     color: Colors.black,
        //   //     size: 24,
        //   //   ),
        //   // ),
        //   /*
        //   // actions プロパティにWidgetを与えると右端に表示されます。
        //   actions: [
        //     // tap 可能にするために InkWell を使います。

        //     InkWell(
        //       onTap: () {
        //         Navigator.of(context).push(
        //           MaterialPageRoute(
        //             builder: (context) {
        //               return const ProfilePage();
        //             },
        //           ),
        //         );
        //       },

        //       child: const Icon(
        //         Icons.more_vert,
        //         color: Colors.black,
        //         size: 24,
        //       ),

        //     ),
        //     const SizedBox(
        //       width: 40,
        //     )
        //   ],*/
        // ),

        /*
          ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text('Test App'),
            ),
            ListTile(
              title: Text('item1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('item2'),
              onTap: () {},
            )
          ]
        )
        */

        body: Container(
          color: Color.fromARGB(255, 3, 23, 77),
          child: Stack(children: [
            Positioned(
              child: Image.asset('images/chat/chatHeader.png'),
            ),
            Column(children: [
              //UnityWidget(onUnityCreated: onUnityCreated),
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 40, right: 40, bottom: 20),
                child: Text(
                  currentRoomName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 228, 228, 228),
                      fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 80, right: 80, bottom: 20),
                child: Text(
                  'ここは日常会話の部屋です。LINEの代わりとしてご活用ください。',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 228, 228, 228),
                      fontSize: 14),
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
                        return PostWidget(post: post);
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
