import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    required this.text,
    required this.roomId,
    required this.createdAt,
    required this.posterName,
    required this.posterImageUrl,
    required this.posterId,
    required this.reference,
    required this.stamps,
  });

  factory Post.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!; // data() の中には Map 型のデータが入っています。
    // data()! この ! 記号は nullable な型を non-nullable として扱うよ！ という意味です。
    // data の中身はかならず入っているだろうという仮説のもと ! をつけています。
    // map データが得られているのでここからはいつもと同じです。
    return Post(
      text: map['text'],
      roomId: map['roomId'],
      createdAt: map['createdAt'],
      posterName: map['posterName'],
      posterImageUrl: map['posterImageUrl'],
      posterId: map['posterId'],
      stamps: map['stamps'],
      reference:
          snapshot.reference, // 注意。reference は map ではなく snapshot に入っています。
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'roomId': roomId,
      'createdAt': createdAt,
      'posterName': posterName,
      'posterImageUrl': posterImageUrl,
      'posterId': posterId,
      'stamps': stamps,
      // 'reference': reference, reference は field に含めなくてよい
      // field に含めなくても DocumentSnapshot に reference が存在するため
    };
  }

  /// 投稿文
  final String text;

  final String roomId;

  /// 投稿日時
  final Timestamp createdAt;

  /// 投稿者の名前
  final String posterName;

  /// 投稿者のアイコン画像URL
  final String posterImageUrl;

  /// 投稿者のユーザーID
  final String posterId;

  final String? stamps;

  /// Firestoreのどこにデータが存在するかを表すpath情報
  final DocumentReference reference;
}
