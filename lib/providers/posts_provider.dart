import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tworoom/providers/auth_provider.dart';

import '../allConstants/all_constants.dart';
import '../models/post.dart';
import 'firebase_provider.dart';
import 'talkroom_provider.dart';

///postReferenceProviderが提供する
///ReferenceにあるPostを取得するプロバイダー
final postsProvider = StreamProvider.family((ref, String roomId) {
  final postsReference = ref.watch(postsReferenceProvider);
  return postsReference
      .where('roomId', isEqualTo: roomId)
      .orderBy('createdAt')
      .snapshots();
});

final postsReverseProvider = StreamProvider.family((ref, String roomId) {
  final postsReference = ref.watch(postsReferenceProvider);
  final uid = ref.watch(uidProvider);
  return postsReference
      .where('roomId', isEqualTo: roomId)
      .where('posterId', isEqualTo: uid)
      .orderBy('createdAt', descending: true)
      .snapshots();
});

///現在のtalkroom直下のpostのReferenceを取得するプロバイダー
final postsReferenceProvider = Provider<CollectionReference<Post>>((ref) {
  final talkroomReference = ref.watch(talkroomReferenceProvider).value;

  ///talkroomReferenceが取得中のときは、空のコレクションを渡す。
  if (talkroomReference == null) {
    final firestore = ref.read(firestoreProvider);
    return firestore.collection('null').withConverter<Post>(
          fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
          toFirestore: ((value, _) => value.toJson()),
        );
  }

  return talkroomReference.collection(Consts.posts).withConverter<Post>(
        fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
        toFirestore: ((value, _) => value.toJson()),
      );
});
