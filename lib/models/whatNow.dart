import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WhatNow {
  String whatNow;

  WhatNow({required this.whatNow});

  factory WhatNow.fromFirestore(Map<String, dynamic> map) {
    // data() の中には Map 型のデータが入っています。
    // data()! この ! 記号は nullable な型を non-nullable として扱うよ！ という意味です。
    // data の中身はかならず入っているだろうという仮説のもと ! をつけています。
    // map データが得られているのでここからはいつもと同じです。
    return WhatNow(
      whatNow: map['whatNow'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'whatNow': whatNow,
      // 'reference': reference, reference は field に含めなくてよい
      // field に含めなくても DocumentSnapshot に reference が存在するため
    };
  }
}

@immutable
class IsUserWhatNow {
  IsUserWhatNow({required this.isUser});
  final bool isUser;
}

class IsUserWhatNowNotifier extends StateNotifier<IsUserWhatNow> {
  IsUserWhatNowNotifier() : super(IsUserWhatNow(isUser: true));

  void IsUserTrue() {
    state = IsUserWhatNow(isUser: true);
  }

  void IsUserChange() {
    state = IsUserWhatNow(isUser: !state.isUser);
  }

  void IsUserFalse() {
    state = IsUserWhatNow(isUser: false);
  }
}

final isUserWhatNowProvider =
    StateNotifierProvider<IsUserWhatNowNotifier, IsUserWhatNow>((ref) {
  return IsUserWhatNowNotifier();
});
