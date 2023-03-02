import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:tworoom/allConstants/all_constants.dart';
import 'package:tworoom/models/room_id_model.dart';

class RoomGridPage1 extends ConsumerStatefulWidget {
  const RoomGridPage1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomGridPage1State();
}

class _RoomGridPage1State extends ConsumerState<RoomGridPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.main,
      child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 30,
                  width: 340,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset('images/roomgrid/TweetRoom.png'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 20),
                        child: Text(
                          'ひとりごと',
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            color: AppColors.red,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )),
              Positioned(
                  top: 280,
                  left: 0,
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MaterialButton(
                          onPressed: () {
                            ref
                                .watch(roomIdProvider.notifier)
                                .setRoomId('date');
                            GoRouter.of(context).push('/RoomGrid1/Chat1');
                          },
                          child: Image.asset('images/roomgrid/DateRoom.png')),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 20),
                        child: Text(
                          '行きたいところ',
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            color: AppColors.red,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )),
              Positioned(
                  top: 310,
                  right: 0,
                  width: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MaterialButton(
                          onPressed: () {
                            ref
                                .watch(roomIdProvider.notifier)
                                .setRoomId('hobby');
                            GoRouter.of(context).push('/RoomGrid1/Chat1');
                          },
                          child: Image.asset('images/roomgrid/HobbyRoom.png')),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 20),
                        child: Text(
                          '趣味',
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            color: AppColors.red,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )),
              Positioned(
                  top: 450,
                  left: 0,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MaterialButton(
                          onPressed: () {
                            ref
                                .watch(roomIdProvider.notifier)
                                .setRoomId('init');
                            GoRouter.of(context).push('/RoomGrid1/Chat1');
                          },
                          child: Image.asset('images/roomgrid/LINERoom.png')),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, right: 20),
                        child: Text(
                          '日常会話',
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            color: AppColors.red,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  )),
              Positioned(right: 10, top: 490, child: AddRoomBox1())
            ],
          )),
    );
  }
}

class AddRoomBox1 extends StatelessWidget {
  const AddRoomBox1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DottedBorder(
        color: Color.fromARGB(255, 40, 96, 83),
        dashPattern: [7, 10],
        strokeWidth: 1.3,
        borderType: BorderType.RRect,
        radius: const Radius.circular(30),
        child: Container(
          width: 110,
          height: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  GoRouter.of(context).push('/RoomGrid/AddRoom');
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.red,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.red,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 212, 212, 212),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Add new item',
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
