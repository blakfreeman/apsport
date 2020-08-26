
import 'package:aptus/model/message.dart';
import 'package:aptus/model/users.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
final _firestore = Firestore.instance;
FirebaseUser loggedInUser;



class Chat extends StatelessWidget {
  final String peerId;///check page details
  final String peerAvatar;
  final OurPlayer ourPlayer;

  Chat({Key key, @required this.peerId, @required this.peerAvatar,this.ourPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHAT',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ChatScreen(
        peerId: peerId,
        peerAvatar: peerAvatar,
        ourPlayer : ourPlayer,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final OurPlayer ourPlayer;

  ChatScreen({Key key, @required this.peerId, @required this.peerAvatar,this.ourPlayer}) : super(key: key);

  @override
  State createState() => ChatScreenState(peerId: peerId, peerAvatar: peerAvatar);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.peerId, @required this.peerAvatar});

  String peerId;
  String peerAvatar;
  String id;
  String ourPlayer;

  var listMessage;
  String groupChatId;
  SharedPreferences prefs; ///check this out

  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController(initialScrollOffset: 50.0);
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);

    groupChatId = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    id = await Provider.of<CurrentUser>(context).getCurrentUID();
    if (id.hashCode <= ourPlayer.hashCode) {
      groupChatId = '$id-$ourPlayer';
    } else {
      groupChatId = '$ourPlayer-$id';
    }

    Firestore.instance.collection('users').document(id).updateData({'chattingWith': widget.ourPlayer.uid});

    setState(() {});/// this one if we can do something with
  }



  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }



  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': widget.ourPlayer.username,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document['idFrom'] == id) {
      // Right (my message)
      return Row(
        children: <Widget>[
          document['type'] == 0
          // Text
              ? Container(
            child: Text(
              document['content'],
              style: TextStyle(color: primaryColor),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(color: greyColor2, borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          )
              : document['type'] == 1
          // Image
              ? Container(
            child: FlatButton(
              child: Material(
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                    ),
                    width: 200.0,
                    height: 200.0,
                    padding: EdgeInsets.all(70.0),
                    decoration: BoxDecoration(
                      color: greyColor2,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Material(
                    child: Image.asset(
                      'images/img_not_available.jpeg',
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                  ),
                  imageUrl: document['content'],
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                clipBehavior: Clip.hardEdge,
              ),
              onPressed: null,
              padding: EdgeInsets.all(0),
            ),
            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          )
          // Sticker
              : Container(
            child: Image.asset(
              'images/${document['content']}.gif',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ),
                      width: 35.0,
                      height: 35.0,
                      padding: EdgeInsets.all(10.0),
                    ),
                    imageUrl: null,
                    width: 35.0,
                    height: 35.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                )
                    : Container(width: 35.0),
                document['type'] == 0
                    ? Container(
                  child: Text(
                    document['content'],
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(left: 10.0),
                )
                    : document['type'] == 1
                    ? Container(
                  child: FlatButton(
                    child: Material(
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                          ),
                          width: 200.0,
                          height: 200.0,
                          padding: EdgeInsets.all(70.0),
                          decoration: BoxDecoration(
                            color: greyColor2,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Material(
                          child: Image.asset(
                            'images/img_not_available.jpeg',
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          clipBehavior: Clip.hardEdge,
                        ),
                        imageUrl: document['content'],
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      clipBehavior: Clip.hardEdge,
                    ),
                    onPressed: null,
                    padding: EdgeInsets.all(0),
                  ),
                  margin: EdgeInsets.only(left: 10.0),
                )
                    : Container(
                  child: Image.asset(
                    'images/${document['content']}.gif',
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                  margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                ),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
              child: Text(
                  'yes'
              ),
              margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
            )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] == id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] != id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Firestore.instance.collection('users').document(id).updateData({'chattingWith': null});
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Sticker
              (isShowSticker ? buildSticker() : Container()),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildSticker() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi1', 2),
                child: Image.asset(
                  'images/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi2', 2),
                child: Image.asset(
                  'images/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi3', 2),
                child: Image.asset(
                  'images/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi4', 2),
                child: Image.asset(
                  'images/mimi4.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi5', 2),
                child: Image.asset(
                  'images/mimi5.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi6', 2),
                child: Image.asset(
                  'images/mimi6.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi7', 2),
                child: Image.asset(
                  'images/mimi7.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi8', 2),
                child: Image.asset(
                  'images/mimi8.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi9', 2),
                child: Image.asset(
                  'images/mimi9.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: greyColor2, width: 0.5)), color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? const CircularProgressIndicator() : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: null,
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.face),
                onPressed: getSticker,
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: greyColor),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(border: Border(top: BorderSide(color: greyColor2, width: 0.5)), color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder(
        stream: Firestore.instance
            .collection('messages')
            .document(groupChatId)
            .collection(groupChatId)
            .orderBy('timestamp', descending: true)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
          } else {
            listMessage = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }
}