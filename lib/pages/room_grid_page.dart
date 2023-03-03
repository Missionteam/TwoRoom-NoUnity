import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dotted_border/dotted_border.dart';

import '../widgets/specific/RoomGridPage/widges_orenge.dart';
import '../widgets/specific/RoomGridPage/widges_yellow copy.dart';

class RoomGridPage extends ConsumerStatefulWidget {
  const RoomGridPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomGridPageState();
}

class _RoomGridPageState extends ConsumerState<RoomGridPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: AppColors.main,
        color: Color.fromARGB(255, 34, 52, 60),
        height: 900,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 45, right: 45, bottom: 40),
          child: Column(children: [
            // RedRoomBox(),
            SizedBox(
              height: 30,
            ),
            OrangeRoomBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                YellowRoomBox(),
                SizedBox(
                  width: 10,
                ),
                AddRoomBox(),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class AddRoomBox extends StatelessWidget {
  const AddRoomBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: DottedBorder(
        color: Color.fromARGB(255, 40, 96, 83),
        dashPattern: [7, 10],
        strokeWidth: 2,
        borderType: BorderType.RRect,
        radius: const Radius.circular(30),
        child: Container(
          width: 100,
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  GoRouter.of(context).push('/RoomGrid/AddRoom');
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 40, 96, 83),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 62, 213, 152),
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
                'Add new room',
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 53, 181, 130),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
