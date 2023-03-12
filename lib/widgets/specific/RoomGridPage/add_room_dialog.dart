import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tworoom/providers/auth_provider.dart';
import 'package:tworoom/providers/rooms_provider.dart';
import 'package:tworoom/providers/talkroom_provider.dart';

import '../../../models/room.dart';

enum RadioColorValue {
  Red,
  Yellow,
  Orange,
}

class AddRoomDialog extends ConsumerStatefulWidget {
  AddRoomDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddRoomDialogState();
}

class _AddRoomDialogState extends ConsumerState<AddRoomDialog> {
  final _formKey = GlobalKey<FormState>();
  String _roomName = '';
  String _description = '';
  RadioColorValue _gValue = RadioColorValue.Yellow;
  _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });
  }

  void _submission() {
    if (this._formKey.currentState!.validate()) {
      this._formKey.currentState!.save();
    }
  }

  Future<void> addRoom(
    String roomname,
    String description,
  ) async {
    final user = ref.watch(authStateProvider).value!;
    final lastRoomIndex = ref.watch(lastRoomIndexProvider).value ?? 1;
    final roomIndex = lastRoomIndex + 1;

    final newDocumentReference = ref.read(roomsReferenceProvider).doc();

    final newRoom = Room(
      roomname: roomname,
      roomId: newDocumentReference.id,
      reference: newDocumentReference,
      roomIndex: roomIndex,
    );

    // 先ほど作った newDocumentReference のset関数を実行するとそのドキュメントにデータが保存されます。
    // 引数として Post インスタンスを渡します。
    // 通常は Map しか受け付けませんが、withConverter を使用したことにより Post インスタンスを受け取れるようになります。
    newDocumentReference.set(newRoom);
    ref
        .watch(talkroomReferenceProvider)
        .value
        ?.update({'lastRoomIndex': roomIndex});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Container(
        width: 360,
        height: 460,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 25,
              left: 20,
              child: Form(
                  key: _formKey,
                  child: Container(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 60, right: 60, bottom: 20),
                      child: Material(
                        child: new TextFormField(
                          enabled: true,
                          maxLength: 20,
                          obscureText: false,
                          initialValue: 'の部屋',
                          decoration: const InputDecoration(
                            hintText: '○○の部屋',
                            labelText: '部屋の名前',
                          ),
                          onSaved: (String? value) {
                            this._roomName = value ?? '';
                          },
                        ),
                      ))),
            ),
            Positioned(
              top: 65,
              left: 20,
              child: Form(
                  key: _formKey,
                  child: Container(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 60, right: 60, bottom: 20),
                      child: Material(
                        child: new TextFormField(
                          enabled: true,
                          maxLength: 20,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: 'この部屋がどんな部屋か説明してください。',
                            labelText: '部屋の説明',
                          ),
                          onSaved: (String? value) {
                            this._description = value ?? '';
                          },
                        ),
                      ))),
            ),
            Positioned(
              child: TextButton(
                  onPressed: () {
                    _submission();
                    addRoom(this._roomName, this._description);
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    fixedSize: Size(150, 40),
                  ),
                  child: Text(
                    '保存',
                    style: GoogleFonts.nunito(
                        // color: Color.fromARGB(255, 243, 243, 243)),
                        color: Colors.white),
                  )),
            ),
            Positioned(
                left: 30,
                bottom: 0,
                width: 100,
                child: Image.asset('images/roomgrid/YellowBoxImage.png')),
          ],
        ),
      ),
    );
  }
}
