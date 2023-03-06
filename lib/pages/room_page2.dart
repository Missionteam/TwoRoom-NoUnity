// ignore_for_file: unused_import, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../models/room.dart';
import '../models/room_id_model.dart';
import '../providers/rooms_provider.dart';

class RoomPage extends ConsumerStatefulWidget {
  const RoomPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomPageState();
}

class _RoomPageState extends ConsumerState<RoomPage> {
  var roomId = 'home';

  Future<void> sendRoom(String roomname) async {
    // まずは user という変数にログイン中のユーザーデータを格納します
    final user = FirebaseAuth.instance.currentUser!;

    // 先ほど作った postsReference からランダムなIDのドキュメントリファレンスを作成します
    // doc の引数を空にするとランダムなIDが採番されます
    final newDocumentReference = ref.read(roomsReferenceProvider).doc();

    final newRoom = Room(
      roomname: roomname,
      roomId: roomname,
      reference: newDocumentReference,
    );

    // 先ほど作った newDocumentReference のset関数を実行するとそのドキュメントにデータが保存されます。
    // 引数として Post インスタンスを渡します。
    // 通常は Map しか受け付けませんが、withConverter を使用したことにより Post インスタンスを受け取れるようになります。
    newDocumentReference.set(newRoom);
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
    return GestureDetector(
      onTap: () {
        primaryFocus?.unfocus();
      },
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(height: 80),
          Text('Rooms',
              style: TextStyle(
                  fontSize: 20, decoration: TextDecoration.underline)),
          Expanded(
            child: ref.watch(roomsProvider).when(
              data: (data) {
                /// 値が取得できた場合に呼ばれる。
                return ListView.builder(
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    final room = data.docs[index].data();
                    // return Text(room.roomname);
                    return TextButton(
                      onPressed: () {
                        String roomId = data.docs[index].id;
                        ref.read(roomIdProvider.notifier).setRoomId(roomId);
                        context.pop();
                      },
                      child: Text(
                        room.roomname,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    );
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
            padding: const EdgeInsets.all(20.0),
            child: Text(
                '申し訳ございません。部屋の追加は現在開発中となっております。\n完成ししだい、アップデートを配布いたしますので、いましばらくお待ちください。'),
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
                sendRoom(text);
                // 入力中の文字列を削除します。
                controller.clear();
              },
            ),
          ),
        ],
      )),
    );
  }
}
