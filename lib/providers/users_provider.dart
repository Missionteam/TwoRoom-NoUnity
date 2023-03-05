import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../allConstants/all_constants.dart';
import '../models/user.dart';
import 'auth_provider.dart';
import 'firestore_provider.dart';

final AppUsersReferenceProvider = Provider<CollectionReference<AppUser>>((ref) {
  final userReference = ref.read(firestoreProvider).collection(Consts.users);

  return userReference.withConverter<AppUser>(
    fromFirestore: ((snapshot, _) {
      return AppUser.fromFirestore(snapshot);
    }),
    toFirestore: ((value, _) {
      return value.toJson();
    }),
  );
});

final currentAppUserDocRefProvider =
    Provider<DocumentReference<AppUser>>((ref) {
  final uid = ref.watch(uidProvider);
  final appUsersReference = ref.watch(AppUsersReferenceProvider);
  return appUsersReference.doc(uid);
});

final CurrentAppUserDocProvider =
    StreamProvider<DocumentSnapshot<AppUser>>((ref) {
  final appUsersReference = ref.watch(currentAppUserDocRefProvider);
  return appUsersReference.snapshots();
});

final partnerUserDocRefProvider = Provider<DocumentReference<AppUser>>((ref) {
  final CurrentUserDoc = ref.watch(CurrentAppUserDocProvider).value;
  final partnerUid = CurrentUserDoc?.get('chattingWith');
  final appUsersReference = ref.watch(AppUsersReferenceProvider);
  return appUsersReference.doc(partnerUid);
});

final partnerUserDocProvider = StreamProvider((ref) {
  final CurrentUserDoc = ref.watch(CurrentAppUserDocProvider).value;
  final partnerUid = CurrentUserDoc?.get('chattingWith');
  final appUserReference = ref.watch(AppUsersReferenceProvider);
  return appUserReference.doc(partnerUid).snapshots();
});

// final EngageStampNameProvider = StreamProvider<String>((ref) {
//   final currentAppUserDoc = ref.watch(CurrentAppUserDocProvider).value;
//   final Stream<String> stampname =
//       currentAppUserDoc?.get('stamp') ?? 'NoStamp.png';
//   return stampname;
// });

final EngageStampNameProvider = FutureProvider<String?>((ref) {
  final currentAppUserDoc = ref.watch(CurrentAppUserDocProvider).value;
  return currentAppUserDoc?.get('stamp');
});

final EngageStampProvider = Provider((ref) {
  final stampnamevalue = ref.watch(EngageStampNameProvider).value;
  final stampname = stampnamevalue ?? 'NoStamp.png';
  return Image.asset('images/${stampname}');
});

final whatNowNameProvider = FutureProvider<String?>((ref) {
  final currentAppUserDoc = ref.watch(CurrentAppUserDocProvider).value;
  return currentAppUserDoc?.get('whatNow');
});

final whatNowProvider = Provider((ref) {
  final stampnamevalue = ref.watch(whatNowNameProvider).value;
  final stampname = stampnamevalue ?? 'NoStamp.png';
  return Image.asset('images/whatNowStamp/${stampname}');
});

final CurrentUserfcmTokenProvider = FutureProvider<String?>((ref) {
  final currentAppUserDoc = ref.watch(CurrentAppUserDocProvider).value;
  return currentAppUserDoc?.get('fcmToken');
});

final PartnerfcmTokenProvider = FutureProvider<String?>((ref) {
  final partnerAppUserDoc = ref.watch(partnerUserDocProvider).value;
  return partnerAppUserDoc?.get('fcmToken');
});
