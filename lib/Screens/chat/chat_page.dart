import 'package:flutter/material.dart';
import 'package:bp/user_preferences.dart';
import 'package:bp/services/centers_services.dart';
import 'package:bp/size_config.dart';

import 'package:bp/colors.dart';
import 'package:bp/models/chatmodel.dart';
import 'package:bp/models/stylists.dart';

import 'package:bp/Components/loadingWidget.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

import 'BubbleChat.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
  static String route = "chat";
}

final prefs = UserPreferences();

TextEditingController _textMessageCtrl = new TextEditingController();
Stream messageStream;

class _ChatScreenState extends State<ChatScreen> {
  //
  @override
  Widget build(BuildContext context) {
    //
    CenterProivder provider = Provider.of<CenterProivder>(context);
    List stylistData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kSecundary,
        title: Text(
          stylistData[0].name,
          style: TextStyle(),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: chatStream(provider, stylistData[1])),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 32,
                  color: Color(0xFF087949).withOpacity(0.1),
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
                            autocorrect: false,
                            onSubmitted: (value) async {
                              await addMessage(provider, stylistData[1]);
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

  Future addMessage(provider, String stylistData) async {
    DateTime now = DateTime.now();

    if (_textMessageCtrl.text.isEmpty) return;

    String messageId;

    Map<String, dynamic> messageInfoMap = {
      "message": _textMessageCtrl.text,
      "sendBy": prefs.userId,
      "ts": now
    };

    if (messageId == '') {
      messageId = randomAlphaNumeric(12);
    }

    final chatRoomId = provider.getChatRoomId(prefs.userId, stylistData);

    await provider.addMessage(chatRoomId, messageId, messageInfoMap).then(
      (value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": _textMessageCtrl.text,
          "lastMessageSentTs": now,
          "lastMessageSendBy": prefs.userId
        };
        provider.updateLastMessageSent(chatRoomId, lastMessageInfoMap);
      },
    );
  }
}

StreamBuilder chatStream(CenterProivder provider, String stylistData) {
  return StreamBuilder(
    stream: provider
        .getChatRoomMessages(provider.getChatRoomId(prefs.userId, stylistData)),
    builder: (context, snap) {
      return snap.hasData
          ? ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: snap.data.docs.length,
              itemBuilder: (context, index) {
                ChatModel message = ChatModel(
                    message: snap.data.docs[index]['message'],
                    sendBy: snap.data.docs[index]['sendBy'],
                    ts: snap.data.docs[index]['ts']);

                return BubbleChat(data: message);
              })
          : LoadingWidget();
    },
  );
}
