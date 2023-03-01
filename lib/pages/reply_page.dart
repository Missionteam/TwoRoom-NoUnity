import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../allConstants/all_constants.dart';
import '../models/post.dart';
import '../models/room_id_model.dart';
import '../widgets/fundomental/post_widget.dart';

class ReplyPage extends ConsumerStatefulWidget {
  const ReplyPage({super.key, required this.post});

  final Post post;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReplyPageState();
}

class _ReplyPageState extends ConsumerState<ReplyPage> {
  Future<void> sendPost(String text) async {
    // まずは user という変数にログイン中のユーザーデータを格納します
    final user = FirebaseAuth.instance.currentUser!;
    final posterId = user.uid; // ログイン中のユーザーのIDがとれます
    final posterName = user.displayName!; // Googleアカウントの名前がとれます
    final posterImageUrl = user.photoURL!; // Googleアカウントのアイコンデータがとれます
    final roomId = ref.watch(roomIdProvider).id;
    final postDoc = widget.post.reference;
    final postRef = postDoc.collection(Consts.posts).withConverter<Post>(
          fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
          toFirestore: ((value, _) => value.toJson()),
        );

    // 先ほど作った postsReference からランダムなIDのドキュメントリファレンスを作成します
    // doc の引数を空にするとランダムなIDが採番されます
    final newDocumentReference = postRef.doc();

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

  @override
  Widget build(BuildContext context) {
    final roomId = ref.watch(roomIdProvider).id;
    final postsDoc = widget.post.reference;
    final postsRef = postsDoc.collection(Consts.posts).withConverter<Post>(
          fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
          toFirestore: ((value, _) => value.toJson()),
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(31, 0, 0, 0),
            size: 24,
          ),
        ),
      ),
      body: Column(children: [
        PostWidget(post: widget.post),
        Divider(
          color: Color.fromARGB(255, 212, 211, 211),
          thickness: 1,
          height: 12,
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Post>>(
            stream: postsRef.snapshots(),
            builder: (context, snapshot) {
              final docs = snapshot.data?.docs ?? [];
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final post = docs[index].data();
                  return PostWidget(post: post);
                },
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
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
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
    );
  }
}
