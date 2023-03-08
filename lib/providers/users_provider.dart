import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../allConstants/all_constants.dart';
import '../models/user.dart';
import 'auth_provider.dart';
import 'firebase_provider.dart';

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
  final String partnerUid = CurrentUserDoc?.get('chattingWith') ?? '';
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

final userWhatNowNameProvider = FutureProvider<String?>((ref) {
  final currentAppUserDoc = ref.watch(CurrentAppUserDocProvider).value;
  return currentAppUserDoc?.get('whatNow');
});

final userWhatNowProvider = Provider((ref) {
  final stampnamevalue = ref.watch(userWhatNowNameProvider).value;
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

final partnerWhatNowNameProvider = FutureProvider<String?>((ref) {
  final partnerAppUserDoc = ref.watch(partnerUserDocProvider).value;
  return partnerAppUserDoc?.get('whatNow');
});

final partnerWhatNowProvider = Provider((ref) {
  final stampnamevalue = ref.watch(partnerWhatNowNameProvider).value;
  final stampname = stampnamevalue ?? 'NoStamp.png';
  return Image.asset('images/whatNowStamp/${stampname}');
});

final whatNowNameProvider = Provider.family((ref, bool isUser) {
  final userWhatNowName =
      ref.watch(userWhatNowNameProvider).value ?? 'NoStamp.png';
  final partnerWhatNowName =
      ref.watch(partnerWhatNowNameProvider).value ?? 'NoStamp.png';

  return (isUser == true) ? userWhatNowName : partnerWhatNowName;
});

final isGirlProvider = Provider<bool>((ref) {
  final bool isGirl =
      ref.watch(CurrentAppUserDocProvider).value?.get('isGirl') ?? true;
  return isGirl;
});

final whatNowDisplayNameProvider = Provider.family((ref, bool isUser) {
  final String userName =
      ref.watch(CurrentAppUserDocProvider).value?.get('displayName') ?? '';
  final String partnerName =
      ref.watch(partnerUserDocProvider).value?.get('displayName') ?? '';

  return (isUser == true) ? userName : partnerName;
});
