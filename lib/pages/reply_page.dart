import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tworoom/widgets/fundomental/post_widget1.dart';

import '../allConstants/all_constants.dart';
import '../models/post.dart';
import '../models/room_id_model.dart';
import '../providers/cloud_messeging_provider.dart';
import '../providers/users_provider.dart';

class ReplyPage extends ConsumerStatefulWidget {
  const ReplyPage({super.key, required this.post});

  final Post post;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReplyPageState();
}

class _ReplyPageState extends ConsumerState<ReplyPage> {
  Future<void> sendPost(String text) async {
    // まずは user という変数にログイン中のユーザーデータを格納します
    final userDoc = ref.watch(CurrentAppUserDocProvider).value;
    final posterId = userDoc?.get('id'); // ログイン中のユーザーのIDがとれます
    final posterName = userDoc?.get('displayName'); // Googleアカウントの名前がとれます
    final posterImageUrl = userDoc?.get('photoUrl'); // Googleア
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

  Future<void> addReplyCount() async {
    final count = widget.post.replyCount;
    widget.post.reference.update({'replyCount': count + 1});
  }

  // build の外でインスタンスを作ります。
  final controller = TextEditingController();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final roomId = ref.watch(roomIdProvider).id;
    final postsDoc = widget.post.reference;
    final postsRef = postsDoc.collection(Consts.posts).withConverter<Post>(
          fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
          toFirestore: ((value, _) => value.toJson()),
        );
    final token = ref.watch(PartnerfcmTokenProvider).value ?? '';

    return Container(
      color: Color.fromARGB(255, 248, 231, 229),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 248, 231, 229),
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
        body: Container(
          color: Color.fromARGB(255, 248, 231, 229),
          child: Column(children: [
            SizedBox(
              height: 14,
            ),
            PostWidget1(
              post: widget.post,
              isReplyPage: true,
            ),
            Divider(
              color: Color.fromARGB(255, 212, 211, 211),
              thickness: 1,
              height: 12,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Post>>(
                stream: postsRef.orderBy('createdAt').snapshots(),
                builder: (context, snapshot) {
                  final docs = snapshot.data?.docs ?? [];
                  postsDoc.update({'replyCount': docs.length});
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final post = docs[index].data();
                      return PostWidget1(post: post);
                    },
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
                            .sendPushNotification(token, '恋人がスレッドで返信しました。', '');
                        controller.clear();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
