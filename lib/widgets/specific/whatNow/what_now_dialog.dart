import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tworoom/widgets/image_buttom.dart';

import '../../../models/whatNow.dart';
import '../../../providers/users_provider.dart';

class WhatNowDialog extends ConsumerStatefulWidget {
  WhatNowDialog({
    Key? key,
    this.Screenpadding =
        const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
  }) : super(key: key);
  EdgeInsetsGeometry Screenpadding;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WhatNowDialogState();
}

class _WhatNowDialogState extends ConsumerState<WhatNowDialog> {
  int index = 1;
  void setActive(String stampname) {
    final currentUserDoc = ref.watch(CurrentAppUserDocProvider).value;
    ref.watch(isUserWhatNowProvider.notifier).IsUserTrue();
    currentUserDoc?.reference.update({'whatNow': '${stampname}.png'});
  }

  @override
  Widget build(BuildContext context) {
    final isGirl = ref.watch(isGirlProvider);
    const workTimepath = 'whatNowStamp/WorkTime/';
    const whatnowpath = 'whatNowStamp/';
    List<Widget> childrenWork = (isGirl == true)
        ? [
            ///girl
            ImageButton(
              imageName: '${workTimepath}WorkGirl1Free.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl1Free');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkGirl118.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl118');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkGirl119.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl119');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkGirl120.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl120');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkGirl121.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl121');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkGirl124.png',
              onPressd: (() {
                setActive('WorkTime/WorkGirl124');
                Navigator.of(context).pop();
              }),
            ),
          ]
        :

        ///boy
        [
            ImageButton(
              imageName: '${workTimepath}WorkBoy1Free.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy1Free');
                Navigator.of(context).pop('/Home1/Home11');
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkBoy118.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy118');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkBoy119.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy119');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkBoy120.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy120');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkBoy121.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy121');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${workTimepath}WorkBoy124.png',
              onPressd: (() {
                setActive('WorkTime/WorkBoy124');
                Navigator.of(context).pop();
              }),
            ),
          ];

    List<Widget> childrenRoutine = (isGirl == true)
        ? [
            ImageButton(
              imageName: '${whatnowpath}WorkGirl1.png',
              onPressd: (() {
                setActive('WorkGirl1');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${whatnowpath}SleepGirl1.png',
              onPressd: (() {
                setActive('SleepGirl1');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${whatnowpath}BreakGirl1.png',
              onPressd: (() {
                setActive('BreakGirl1');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${whatnowpath}NowReady.png',
              onPressd: (() {
                setActive('BreakGirl1');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${whatnowpath}NowReady.png',
              onPressd: (() {
                setActive('BreakGirl1');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${whatnowpath}NowReady.png',
              onPressd: (() {
                setActive('BreakGirl1');
                Navigator.of(context).pop();
              }),
            ),
          ]
        :

        ///男routine
        [
            ImageButton(
              imageName: '${whatnowpath}WorkBoy1.png',
              onPressd: (() {
                setActive('WorkBoy1');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${whatnowpath}SleepBoy1.png',
              onPressd: (() {
                setActive('SleepBoy1');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${whatnowpath}BreakBoy1.png',
              onPressd: (() {
                setActive('BreakBoy1');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${whatnowpath}NowReady.png',
              onPressd: (() {
                setActive('BreakBoy1');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${whatnowpath}NowReady.png',
              onPressd: (() {
                setActive('BreakBoy1');
                Navigator.of(context).pop();
              }),
            ),
            ImageButton(
              imageName: '${whatnowpath}NowReady.png',
              onPressd: (() {
                setActive('BreakBoy1');
                Navigator.of(context).pop();
              }),
            ),
          ];
    final childrenEmotion = [
      ImageButton(
        imageName: '${whatnowpath}BreakGirl1.png',
        onPressd: (() {
          setActive('BreakGirl1');
          Navigator.of(context).pop();
        }),
      ),
    ];
    List<Widget> children = (index == 0)
        ? childrenWork
        : (index == 1)
            ? childrenRoutine
            : (index == 2)
                ? childrenEmotion
                : childrenWork;

    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: widget.Screenpadding,
        child: Column(
          children: [
            Container(
              height: 570,
              color: Colors.white,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                padding:
                    EdgeInsets.only(bottom: 30, left: 30, right: 30, top: 50),
                children: children,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 238, 225),
                  ),
                  onPressed: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Text(
                    '仕事',
                    style: GoogleFonts.nunito(color: Colors.black),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 238, 225),
                  ),
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                    ;
                  },
                  child: Text(
                    '日常',
                    style: GoogleFonts.nunito(color: Colors.black),
                  ),
                ),
                // TextButton(
                //   style: TextButton.styleFrom(
                //     backgroundColor: Color.fromARGB(255, 255, 238, 225),
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       index = 2;
                //     });
                //   },
                //   child: Text(
                //     '感情',
                //     style: GoogleFonts.nunito(color: Colors.black),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
