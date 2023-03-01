import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../allConstants/all_constants.dart';
import 'whatNow.dart';

class AppUser extends Equatable {
  final String id;
  final String photoUrl;
  final String displayName;
  final String phoneNumber;
  final String aboutMe;
  final String talkroomId;
  final String partnerUid;
  final WhatNow whatNow;
  const AppUser(
      {required this.id,
      required this.photoUrl,
      required this.displayName,
      required this.phoneNumber,
      required this.aboutMe,
      required this.talkroomId,
      required this.partnerUid,
      required this.whatNow});

  AppUser copyWith({
    String? id,
    String? photoUrl,
    String? nickname,
    String? phoneNumber,
    String? email,
    String? talkroomId,
    String? partnerUid,
    WhatNow? whatNow,
  }) =>
      AppUser(
          id: id ?? this.id,
          photoUrl: photoUrl ?? this.photoUrl,
          displayName: nickname ?? displayName,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          aboutMe: email ?? aboutMe,
          talkroomId: talkroomId ?? this.talkroomId,
          partnerUid: partnerUid ?? this.partnerUid,
          whatNow: whatNow ?? this.whatNow);

  Map<String, dynamic> toJson() => {
        Consts.displayName: displayName,
        Consts.photoUrl: photoUrl,
        Consts.phoneNumber: phoneNumber,
        Consts.aboutMe: aboutMe,
        Consts.talkroomId: talkroomId,
        Consts.partnerUid: partnerUid,
        Consts.whatNow: whatNow,
      };
  factory AppUser.fromFirestore(DocumentSnapshot snapshot) {
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";
    String aboutMe = "";
    String talkroomId = "";
    String partnerUid = '';
    WhatNow whatNow = WhatNow(whatNow: '');

    try {
      photoUrl = snapshot.get(Consts.photoUrl);
      nickname = snapshot.get(Consts.displayName);
      phoneNumber = snapshot.get(Consts.phoneNumber);
      aboutMe = snapshot.get(Consts.aboutMe);
      talkroomId = snapshot.get(Consts.talkroomId);
      partnerUid = snapshot.get(Consts.partnerUid);
      whatNow = snapshot.get(Consts.whatNow);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return AppUser(
        id: snapshot.id,
        photoUrl: photoUrl,
        displayName: nickname,
        phoneNumber: phoneNumber,
        aboutMe: aboutMe,
        talkroomId: talkroomId,
        partnerUid: partnerUid,
        whatNow: whatNow);
  }
  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, photoUrl, displayName, phoneNumber, aboutMe, talkroomId];
}
