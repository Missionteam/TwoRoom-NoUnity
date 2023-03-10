import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/post.dart';
import '../../../pages/reply_page.dart';

class TweetWidget extends ConsumerStatefulWidget {
  const TweetWidget({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TweetWidgetState();
}

class _TweetWidgetState extends ConsumerState<TweetWidget> {
  Future<void> updatePost(String text) async {
    widget.post.reference.update({'stamps': text});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      Padding(
        padding: const EdgeInsets.only(right: 30, top: 40),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 200),
          child: InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                useRootNavigator: true,
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 330,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () => updatePost('🤗'),
                                    child: Text('🤗',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        )),
                                  ),
                                  TextButton(
                                    onPressed: () => updatePost('🙆‍♂️'),
                                    child: Text('🙆‍♂️',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        )),
                                  ),
                                  TextButton(
                                    onPressed: () => updatePost('🥺'),
                                    child: Text('🥺',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        )),
                                  ),
                                  TextButton(
                                    onPressed: () => updatePost('❤️'),
                                    child: Text('❤️',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        )),
                                  ),
                                  TextButton(
                                    onPressed: () => updatePost('🤔'),
                                    child: Text('🤔',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        )),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () => null,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'メッセージを編集する',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => null,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '未読にする',
                                    style: const TextStyle(
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
                                    '後でリマインドする',
                                    style: const TextStyle(
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
                                    'ブックマークに登録する',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          ReplyPage(post: widget.post))));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'スレッドで返信する',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25, left: 20, bottom: 25, right: 20),
                  child: Text(
                    widget.post.text,
                    style: TextStyle(height: 1.5),
                  ),
                )),
          ),
        ),
      ),
      Positioned(
        right: 50,
        bottom: 10,
        child: Text(widget.post.stamps ?? ''),
      ),
    ]);
  }
}
