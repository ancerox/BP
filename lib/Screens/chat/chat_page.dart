import 'package:bp/Components/loadingWidget.dart';
import 'package:bp/colors.dart';
import 'package:bp/models/stylists.dart';
import 'package:bp/services/centers_services.dart';
import 'package:bp/size_config.dart';
import 'package:bp/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
  static String route = "chat";
}

TextEditingController _textMessageCtrl = new TextEditingController();
Stream messageStream;

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    StylistData stylistData = ModalRoute.of(context).settings.arguments;
    final provider = Provider.of<CenterProivder>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kSecundary,
        title: Text(
          stylistData.name,
          style: TextStyle(),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: chatStream()),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 32,
                  color: Color(0xFF087949).withOpacity(0.08),
                ),
              ],
            ),
            padding: EdgeInsets.all(getPSH(10)),
            width: double.infinity,
            height: getPSH(80),
            child: Row(
              children: [
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.010),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              await addMessage(provider);
                              _textMessageCtrl.clear();
                            },
                            controller: _textMessageCtrl,
                            decoration: InputDecoration(
                              hintText: "Type message",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.attach_file,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.64),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.64),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<CenterProivder>(context, listen: false);
      this.getAndSetMessages(provider);
    });
  }

  getAndSetMessages(provider) async {
    messageStream = await provider
        .getChatRoomMessages('18298281232_DUpa3HUZOHZ7qlEaYjX60ZzFTYg1');
    setState(() {});
  }

  Future addMessage(provider) async {
    if (_textMessageCtrl.text.isEmpty) return;
    final prefs = UserPreferences();
    final now = DateTime.now();

    Map<String, dynamic> messageInfoMap = {
      "message": _textMessageCtrl.text,
      "sendBy": prefs.userId,
      "ts": now
    };
    if (messageId == "") {
      messageId = randomAlpha(12);
    }

    final chatRoomId = provider.getChatRoomId(prefs.userId, '18298281232');

    await provider
        .addMessage(chatRoomId, messageId, messageInfoMap)
        .then((value) {
      Map<String, dynamic> lastMessageInfoMap = {
        "lastMessage": _textMessageCtrl.text,
        "lastMessageSentTs": now,
        "lastMessageSendBy": prefs.userId
      };
      provider.updateLastMessageSent(chatRoomId, lastMessageInfoMap);
    });

    // _textMessageCtrl.clear();
  }

  String messageId;
}

Widget chatStream() {
  return StreamBuilder(
    stream: messageStream,
    builder: (context, snap) {
      return snap.hasData
          ? ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: snap.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snap.data.docs[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(
                          horizontal: getPSW(10), vertical: getPSH(5)),
                      padding: EdgeInsets.all(getPSW(10)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(getPSW(20)),
                              topRight: Radius.circular(getPSW(20)),
                              bottomLeft: Radius.circular(getPSW(20)),
                              bottomRight: Radius.circular(getPSW(0))),
                          color: kPrimeryColor),
                      child: Text(
                        data['message'],
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: getPSW(14),
                        ),
                      ),
                    ),
                  ],
                );
              })
          : LoadingWidget();
    },
  );
}
