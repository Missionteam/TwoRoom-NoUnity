import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:tworoom/models/whatNow.dart';

import '../models/gage_model.dart';
import '../providers/users_provider.dart';
import '../widgets/image_buttom.dart';
import '../widgets/specific/whatNow/what_now_dialog.dart';

class HomePage11 extends ConsumerStatefulWidget {
  const HomePage11({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage11> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  // late UnityWidgetController unityWidgetController;
  bool isWoman = true;

  // @override
  // void dispose() {
  //   unityWidgetController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final gage = ref.watch(GageProvider).gage;
    final isUserWhatNow = ref.watch(isUserWhatNowProvider).isUser;
    final WhatNowName = ref.watch(whatNowNameProvider(isUserWhatNow));
    final displayName = ref.watch(whatNowDisplayNameProvider(isUserWhatNow));

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Container(
          width: double.infinity,
          // color: AppColors.main,
          color: Color.fromARGB(255, 255, 239, 225),
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 350,
                  child: SizedBox(
                    height: 370,
                    width: 270,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // UnityWidget(
                        //   onUnityCreated: onUnityCreated,
                        //   fullscreen: false,
                        // ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Image.asset(
                                  'images/whatNowStamp/${WhatNowName}'),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(displayName),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () => showWhatNow(context),
                          onHorizontalDragEnd: (details) {
                            ref
                                .watch(isUserWhatNowProvider.notifier)
                                .IsUserChange();
                          },
                        ),

                        // MaterialButton(
                        //   height: 200,
                        //   minWidth: 200,
                        //   onPressed: () => showWhatNow(context),
                        // )
                      ],
                    ),
                  ),
                ),
                // MaterialButton(
                //   // elevation: 8.0,
                //   child: Container(
                //     height: 50,
                //     width: 250,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage('images/SorryForLate.png'),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                //   onPressed: () {
                //     showDialog(
                //         context: context,
                //         builder: (_) {
                //           return SorryGirdDialog();
                //           // return EngageDialog();
                //         });
                //   },
                //   // onPressed: () {}
                // ),
              ],
            ),
            // Positioned(
            //     right: 50,
            //     top: 30,
            //     child: CustomPaint(
            //       size: Size(40, 40),
            //       painter: DrawTriangle(ref),
            //     )),
            // Positioned(
            //     left: 120,
            //     top: 80,
            //     width: 200,
            //     child: Image.asset('images/whatNowStamp/WaitReply.png')),
            Positioned(
                width: 70,
                height: 70,
                left: 50,
                top: 220,
                child: ref.watch(EngageStampProvider)

                // ),
                )
          ]),
        ),
      ),
    );
  }

  Future<dynamic> showWhatNow(BuildContext context) {
    final isGirl = ref.watch(isGirlProvider);
    return showDialog(
        context: context,
        builder: (_) {
          const workTimepath = 'whatNowStamp/WorkTime/';
          const whatnowpath = 'whatNowStamp/';
          return WhatNowDialog(
            childrenWork: (isGirl == true)
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
                        GoRouter.of(context).push('/Home1/Home11');
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
                  ],
            childrenRoutine: (isGirl == true)
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
                  ],
            childrenEmotion: [
              ImageButton(
                imageName: '${whatnowpath}BreakGirl1.png',
                onPressd: (() {
                  setActive('BreakGirl1');
                  Navigator.of(context).pop();
                }),
              ),
            ],
          );
          // return EngageDialog();
        });
  }

  void setActive(String stampname) {
    final currentUserDoc = ref.watch(CurrentAppUserDocProvider).value;
    ref.watch(isUserWhatNowProvider.notifier).IsUserTrue();
    currentUserDoc?.reference.update({'whatNow': '${stampname}.png'});
  }
  // void setActive(String object) {
  //   ///Activeは最後に実行。
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWaitGirl',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWalkGirl',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWorkGirl',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishSleepGirl',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWaitBoy',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWalkBoy',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishWorkBoy',
  //     '',
  //   );
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'VanishSleepBoy',
  //     '',
  //   );

  //   ///Active
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'Active${object}',
  //     object,
  //   );
  // }

  // void setVanish(String object) {
  //   unityWidgetController.postMessage(
  //     'ActiveChanger',
  //     'Vanish${object}',
  //     object,
  //   );
  // }

  // void onUnitySceneLoaded(SceneLoaded scene) {
  //   print('Received scene loaded from unity: ${scene.name}');
  //   print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  // }

  // void onUnityCreated(controller) {
  //   controller.resume();
  //   unityWidgetController = controller;
  // }
}
