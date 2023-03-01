import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../models/room_id_model.dart';

class RoomGridPageTest extends ConsumerStatefulWidget {
  const RoomGridPageTest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RoomGridPageTestState();
}

class _RoomGridPageTestState extends ConsumerState<RoomGridPageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        padding: EdgeInsets.only(bottom: 30, left: 30, right: 30, top: 50),
        children: [
          MaterialButton(
              elevation: 8.0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/GiveStamp.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onPressed: () {
                ///ここに適切なルームIDを入力
                ref.watch(roomIdProvider.notifier).setRoomId('');
                GoRouter.of(context).go('/RoomGrid/Chat');
              }),
          MaterialButton(
              elevation: 8.0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/GiveStamp.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onPressed: () {
                ///ここに適切なルームIDを入力
                ref.watch(roomIdProvider.notifier).setRoomId('');
                GoRouter.of(context).go('/RoomGrid/Chat');
              }),
          Container(
            color: Colors.yellow,
            height: 50,
            alignment: Alignment.center,
            child: Text('彼氏'),
          ),
          Container(
            color: Colors.yellow,
            height: 50,
            alignment: Alignment.center,
            child: Text('彼氏'),
          ),
          Container(
            color: Colors.yellow,
            height: 50,
            alignment: Alignment.center,
            child: Text('彼氏'),
          ),
        ],
      ),
    );
  }
}
