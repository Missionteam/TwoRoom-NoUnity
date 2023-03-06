import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/post.dart';

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
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      Padding(
        padding: const EdgeInsets.only(right: 30, top: 40),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 200),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 45, left: 20, bottom: 45, right: 20),
                child: Text(
                  widget.post.text,
                  style: TextStyle(height: 1.5),
                ),
              )),
        ),
      )
    ]);
  }
}
