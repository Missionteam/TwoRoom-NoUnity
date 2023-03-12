import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../allConstants/all_Constants.dart';
import '../models/post.dart';
import '../models/room.dart';
import 'auth_provider.dart';
import 'firebase_provider.dart';

///ユーザーはログインしてるし、TalkroomIdはなかったら作る。//talkroomidはnullの場合がある。
final talkroomIdProvider = FutureProvider<String>((ref) async {
  final firestore = ref.read(firestoreProvider);
  final String? uid = ref.read(uidProvider);
  if (uid == null) {
    throw Exception('ログインしていません。');
  }

  final userDocRef = firestore.collection(Consts.users).doc(uid);
  final userDocumentSnapshot = await userDocRef.get();
  String getTalkroomId(talkroomId) {
    if (talkroomId != null) {
      return userDocumentSnapshot.get(Consts.talkroomId)!;
    } else {
      userDocRef.update({Consts.talkroomId: uid});
      return userDocumentSnapshot.get(Consts.talkroomId)!;
    }
  }

  if (userDocumentSnapshot.exists) {
    final String? talkroomId = userDocumentSnapshot.get(Consts.talkroomId);
    return getTalkroomId(talkroomId);
  }

  ///ユーザーDocがないときはDocを作成後talkroomIdを取得。
  else {
    await firestore
        .collection(Consts.users)
        .doc(uid)
        .set({Consts.talkroomId: uid});
    final userReDocumentSnapshot =
        await firestore.collection(Consts.users).doc(uid).get();
    final String talkroomId = userReDocumentSnapshot.get(Consts.talkroomId);
    return getTalkroomId(talkroomId);
  }
});

final talkroomReferenceProvider = FutureProvider((ref) async {
  final firestore = ref.read(firestoreProvider);
  final uid = ref.watch(uidProvider);
  final String? talkroomId = ref.watch(talkroomIdProvider).value;
  final talkDocroomRef = firestore.collection(Consts.talkrooms).doc(talkroomId);
  final talkroomDoc = await talkDocroomRef.get();
  if (talkroomId == null) {
    return null;
  }

  ///talkroomDocが存在しないときに、talkroomを生成。
  void talkroomsetter() {
    talkDocroomRef.set({
      'users': [uid],
      'lastRoomIndex': 1
    });
    talkDocroomRef.collection(Consts.posts).doc();
    final initpost = Post(
        text:
            'ここは思ったことを自由につぶやける部屋です。画面右下の部屋では自分のつぶやきのみが表示され、「つぶやきの部屋」でパートナーのつぶやきを見ることができます。\n ふと思った何気ないことを言葉にしてみることで、何か面白いことが起きるかもしれません。',
        roomId: 'tweet',
        createdAt: Timestamp.now(),
        posterName: '運営より',
        posterImageUrl: 'Boy',
        posterId: uid ?? '',
        stamps: '😌',
        reference: talkDocroomRef.collection(Consts.posts).doc('init'));
    final initPostDoc = talkDocroomRef.collection(Consts.posts).doc('init');
    initPostDoc.set(initpost.toJson());
    final secondpost = Post(
        text: '試しに呟いてみましょう',
        roomId: 'tweet',
        createdAt: Timestamp.now(),
        posterName: '運営より',
        posterImageUrl: 'Boy',
        posterId: uid ?? '',
        stamps: '😌',
        reference: talkDocroomRef.collection(Consts.posts).doc('init'));
    final secondPostDoc = talkDocroomRef.collection(Consts.posts).doc('second');
    secondPostDoc.set(secondpost.toJson());

    final _initroom = Room(
        roomname: '日常会話の部屋',
        roomId: 'init',
        reference: talkDocroomRef.collection(Consts.rooms).doc('init'));
    final _initRoomDoc = talkDocroomRef.collection(Consts.rooms).doc('init');
    final _tweetroom = Room(
        roomname: 'つぶやきの部屋',
        roomId: 'tweet',
        description: 'ここは思ったことを自由につぶやける部屋です。\n4つめのアイコンからもつぶやきができます。',
        reference: talkDocroomRef.collection(Consts.rooms).doc('tweet'));
    final _tweetRoomDoc = talkDocroomRef.collection(Consts.rooms).doc('tweet');
    final _dateroom = Room(
        roomname: '行きたいところの部屋',
        roomId: 'date',
        reference: talkDocroomRef.collection(Consts.rooms).doc('date'));
    final _dateRoomDoc = talkDocroomRef.collection(Consts.rooms).doc('date');
    final _hobbyroom = Room(
        roomname: '趣味を語る部屋',
        roomId: 'hobby',
        description: 'ここは好きなことについて語る部屋です。\n普段話せない、自分の趣味についてたっぷり話してみませんか？',
        reference: talkDocroomRef.collection(Consts.rooms).doc('hobby'));
    final _hobbyRoomDoc = talkDocroomRef.collection(Consts.rooms).doc('hobby');
    final _myroom = Room(
        roomname: '趣味を語る部屋',
        roomId: 'my',
        reference: talkDocroomRef.collection(Consts.rooms).doc('my'));
    final _myRoomDoc = talkDocroomRef.collection(Consts.rooms).doc('my');

    _initRoomDoc.set(_initroom.toJson());
    _tweetRoomDoc.set(_tweetroom.toJson());
    _dateRoomDoc.set(_dateroom.toJson());
    _hobbyRoomDoc.set(_hobbyroom.toJson());
    _myRoomDoc.set(_myroom.toJson());
  }

  if (talkroomDoc.exists) {
    return talkDocroomRef;
  } else {
    print('tester');
    talkroomsetter();
    final retalkDocroomRef =
        await firestore.collection(Consts.talkrooms).doc(talkroomId);
    return retalkDocroomRef;
  }
});

final lastRoomIndexProvider = FutureProvider<int>((ref) async {
  final currentTalkroomSnapshot =
      await ref.watch(talkroomReferenceProvider).value?.get();
  final int lastRoomIndex = currentTalkroomSnapshot?.get('lastRoomIndex') ?? 1;

  return lastRoomIndex;
});
