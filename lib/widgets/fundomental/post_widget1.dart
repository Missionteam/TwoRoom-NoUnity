import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import '../../models/post.dart';
import '../../models/room.dart';
import '../../pages/reply_page.dart';

class PostWidget1 extends ConsumerWidget {
  const PostWidget1({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> updatePost(String text) async {
      post.reference.update({'stamps': text});
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            // backgroundImage: NetworkImage(
            //   post.posterImageUrl,
            // ),
            backgroundImage:
                AssetImage('images/${post.posterImageUrl}Icon.png'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.posterName,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          color: Color.fromARGB(255, 194, 102, 102)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          DateFormat('MM/dd HH:mm')
                              .format(post.createdAt.toDate()),
                          style: const TextStyle(
                              fontSize: 8,
                              color: Color.fromARGB(126, 48, 48, 48)),
                        ),
                      ],
                    )
                  ],
                ),
                MaterialButton(
                  height: null,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showModalBottomSheet<void>(
                      useRootNavigator: true,
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 330,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          updatePost('🤗');
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('🤗',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          updatePost('🙆‍♂️');
                                        },
                                        child: Text('🙆‍♂️',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          updatePost('🥺');
                                        },
                                        child: Text('🥺',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          updatePost('❤️');
                                        },
                                        child: Text('❤️',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          updatePost('🤔');
                                        },
                                        child: Text('🤔',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  ReplyPage(post: post))));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'スレッドで返信する',
                                        style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'ごめんね、今返信できない(準備中)',
                                        style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '考え中です(準備中)',
                                        style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // TextButton(
                                  //   onPressed: () => null,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Text(
                                  //       '後でリマインドする',
                                  //       style: const TextStyle(
                                  //         fontSize: 14,
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // TextButton(
                                  //   onPressed: () => null,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Text(
                                  //       'ブックマークに登録する',
                                  //       style: const TextStyle(
                                  //         fontSize: 14,
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                    child: Text(
                      post.text,
                      style: const TextStyle(
                        fontSize: 14.6,
                        color: Color.fromARGB(225, 59, 59, 59),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: (post.stamps == '') ? 0 : 38,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ElevatedButton(
                      onPressed: (() => null),
                      child: Text(post.stamps ?? ''),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Color.fromARGB(69, 255, 251, 251),
                        // shadowColor: Color.fromARGB(255, 194, 194, 194),
                        elevation: 0,
                        padding: EdgeInsets.all(0),
                        // maximumSize: Size(0.1, 0.1)
                        // (post.stamps == null) ? Size(0, 0) : Size(40, 40),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoomWidget extends StatelessWidget {
  const RoomWidget({
    Key? key,
    required this.room,
  }) : super(key: key);

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        room.roomname,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
  // if (FirebaseAuth.instance.currentUser!.uid == post.posterId)
  //   IconButton(
  //       onPressed: () {
  //         post.reference.delete();
  //       },
  //       icon: const Icon(Icons.delete)),

}
