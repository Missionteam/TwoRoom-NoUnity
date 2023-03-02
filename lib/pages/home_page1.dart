import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tworoom/allConstants/color_constants.dart';
import 'package:tworoom/models/version_model.dart';

import '../models/gage_model.dart';
import '../providers/users_provider.dart';
import '../widgets/image_buttom.dart';
import '../widgets/specific/whatNow/what_now_dialog.dart';

class HomePage1 extends ConsumerStatefulWidget {
  const HomePage1({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePage1State();
}

class HomePage1State extends ConsumerState<HomePage1> {
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
    final version = ref.watch(versionsProvider);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: Expanded(
          child: Container(
            color: AppColors.main,
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Expanded(child: Container()),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: SizedBox(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // UnityWidget(
                          //   onUnityCreated: onUnityCreated,
                          //   fullscreen: false,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 50, left: 30, right: 30, top: 80),
                            child: Image.asset(
                              'images/home/homeimg.png',
                              fit: BoxFit.contain,
                            ),
                          )
                          // ref.watch(whatNowProvider),
                          // GestureDetector(
                          //   onTap: () => showWhatNow(context),
                          //   onHorizontalDragEnd: (details) {
                          //     if (details.primaryVelocity! < 0) {
                          //       setActive('WaitGirl');
                          //     } else {
                          //       setActive('SleepBoy');
                          //     }
                          //   },
                          // )
                          // MaterialButton(
                          //   height: 200,
                          //   minWidth: 200,
                          //   onPressed: () => showWhatNow(context),
                          // )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    child: TextButton(
                        onPressed: () =>
                            GoRouter.of(context).push('/Home1/Chat1'),
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: Size(150, 40),
                        ),
                        child: Text(
                          'トークする',
                          style: GoogleFonts.nunito(
                              color: Color.fromARGB(255, 243, 243, 243)),
                        )),
                  )
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
                  right: 40,
                  top: 40,
                  child: Image.asset('images/home/settings1.png')),
              Positioned(
                  width: 70,
                  height: 70,
                  left: 50,
                  top: 220,
                  child: ref.watch(EngageStampProvider)
                  // ),
                  ),
              Positioned(
                  left: 0,
                  top: 0,
                  width: 150,
                  child: MaterialButton(
                    child: Container(
                      width: 80,
                      height: 150,
                    ),
                    onPressed: () {
                      ref.watch(versionsProvider.notifier).setVersions();
                    },
                    hoverColor: (version == 0)
                        ? Colors.red
                        : (version == 1)
                            ? Colors.blue
                            : Colors.green,
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showWhatNow(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          const workTimepath = 'whatNowStamp/WorkTime/';
          const whatnowpath = 'whatNowStamp/';
          return WhatNowDialog(
            childrenWork: [
              ImageButton(
                imageName: '${workTimepath}WorkGirl0.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${workTimepath}WorkGirl18.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${workTimepath}WorkGirl19.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${workTimepath}WorkGirl20.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${workTimepath}WorkGirl21.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${workTimepath}WorkGirl24.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
            ],
            childrenRoutine: [
              ImageButton(
                imageName: '${whatnowpath}WalkGirl.jpg',
                onPressd: (() {
                  setActive('WalkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${whatnowpath}SleepGirl.jpg',
                onPressd: (() {
                  setActive('SleepGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${whatnowpath}BreakGirl.jpg',
                onPressd: (() {
                  setActive('BreakGirl');
                  GoRouter.of(context).pop();
                }),
              ),
            ],
            childrenEmotion: [
              ImageButton(
                imageName: '${whatnowpath}BreakGirl.jpg',
                onPressd: (() {
                  setActive('BreakGirl');
                  GoRouter.of(context).pop();
                }),
              ),
            ],
          );
          // return EngageDialog();
        });
  }

  void setActive(String stampname) {
    final currentUserDoc = ref.watch(CurrentAppUserDocProvider).value;
    currentUserDoc?.reference.update({'whatNow': '${stampname}.jpg'});
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
