import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/room.dart';
import '../models/room_id_model.dart';
import 'firebase_provider.dart';
import 'talkroom_provider.dart';

final roomsProvider = StreamProvider((ref) {
  final roomsReference = ref.watch(roomsReferenceProvider);
  return roomsReference.snapshots();
});

final roomsReferenceProvider = Provider<CollectionReference<Room>>((ref) {
  final talkroomReference = ref.watch(talkroomReferenceProvider).value;
  if (talkroomReference == null) {
    final firestore = ref.read(firestoreProvider);
    return firestore.collection('null').withConverter<Room>(
          fromFirestore: ((snapshot, _) => Room.fromFirestore(snapshot)),
          toFirestore: ((value, _) => value.toJson()),
        );
  }

  return talkroomReference.collection('rooms').withConverter<Room>(
    fromFirestore: ((snapshot, _) {
      return Room.fromFirestore(snapshot);
    }),
    toFirestore: ((value, _) {
      return value.toJson();
    }),
  );
});

final currentRoomProvider = FutureProvider<DocumentSnapshot<Room>>((ref) async {
  final roomId = ref.watch(roomIdProvider).id;
  final RoomsRef = ref.watch(roomsReferenceProvider);
  final currentRoom = await RoomsRef.doc(roomId).get();
  return currentRoom;
});

final currentRoomNameProvider = FutureProvider<String?>((ref) async {
  final currentRoom = ref.watch(currentRoomProvider).value;
  final currentroomName = await currentRoom?.get('roomname');
  return currentroomName;
});

final currentRoomDescriptionProvider = FutureProvider<String?>((ref) async {
  final currentRoom = ref.watch(currentRoomProvider).value;
  final currentroomDescription = await currentRoom?.get('description');
  return currentroomDescription;
});
