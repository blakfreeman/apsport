import 'package:aptus/model/users.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

FirebaseUser loggedInUser;
OurPlayer currentUser;

class Chat extends StatefulWidget {
  static const String id = 'chat_screen';
  final OurPlayer ourPlayer;
  final String chatRoomId;
  final String currentUserEmail;

  Chat({this.ourPlayer,this.chatRoomId,this.currentUserEmail});



  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isMyTrainingMate = false;
  final trainingMateIFollowRef = Firestore.instance.collection('Training Mate I follow');
  final trainingMateWhoFollowMeRef = Firestore.instance.collection('Training Mate who follow me');
  final trainingMateRef = Firestore.instance.collection('Mate reference');
  final usersRef = Firestore.instance.collection('users');
  @override
  void initState() {
    OurDatabase().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    getCurrentUser();
    super.initState();
    checkITrainingMate();
  }

  checkITrainingMate() async {
    final uid =  await Provider.of<CurrentUser>(context, listen: false).getCurrentUID();
    DocumentSnapshot doc = await trainingMateIFollowRef
        .document(widget.ourPlayer.uid)
        .collection('userFollowers')
        .document(uid)
        .get();
    setState(() {
      isMyTrainingMate = doc.exists;
    });
  }



  Widget chatMessages(){
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return MessageTile(
                message: snapshot.data.documents[index].data["message"],
                sendByMe: loggedInUser.email == snapshot.data.documents[index].data["sendBy"],
                receiver: snapshot.data.documents[index].data["receiver"],


              );
            }) : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": loggedInUser.email,
        "message": messageEditingController.text,
        "receiver": widget.ourPlayer.username,
        'time': DateTime
            .now()
            .millisecondsSinceEpoch,
      };

      OurDatabase().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  buildChatButton() {
    if (isMyTrainingMate ) {
      return buildButton( text: 'yes',function: handleRemoveTrainingMat
      );
    } else if (!isMyTrainingMate) {
      return buildButton( text: 'no',function: handleAddTrainingMat);
    }
  }

  handleAddTrainingMat ()  async {

    setState(() {
      isMyTrainingMate = true;
    });
    final uid =  await Provider.of<CurrentUser>(context, listen: false).getCurrentUID();
    DocumentSnapshot  doc = await usersRef.document(uid).get();
    currentUser = OurPlayer.fromDocument(doc);
    // Make auth user follower of THAT user (update THEIR followers collection)
    trainingMateIFollowRef
        .document(widget.ourPlayer.uid)
        .collection('userFollowers')
        .document(uid)
        .setData({});
    // Put THAT user on YOUR following collection (update your following collection)
    trainingMateWhoFollowMeRef
        .document(uid)
        .collection('userFollowing')
        .document(widget.ourPlayer.uid)
        .setData({});
    // add activity feed item for that user to notify about new follower (us)
    trainingMateRef
        .document(widget.ourPlayer.uid)
        .collection('feedItems')
        .document(uid)
        .setData({
      "type": "follow",
      "ownerId": uid,
      "username": currentUser.username,
      "userId": uid,
      "userProfileImg": currentUser.photoUrl,
      "timestamp": DateTime.now(),
    });

  }
  handleRemoveTrainingMat () async {
    setState(() {
      isMyTrainingMate = false;
    });
    // remove follower
    final uid =  await Provider.of<CurrentUser>(context, listen: false).getCurrentUID();
    trainingMateIFollowRef
        .document(widget.ourPlayer.uid)
        .collection('userFollowers')
        .document(uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // remove following
    trainingMateWhoFollowMeRef
        .document(uid)
        .collection('userFollowing')
        .document(widget.ourPlayer.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // delete activity feed item for them
    trainingMateRef
        .document(widget.ourPlayer.uid)
        .collection('feedItems')
        .document(uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

  }
/// TO delet if everythings works well
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Container buildButton({String text, Function function}) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: FlatButton(
        onPressed: function,
        child: Container(
          width: 30.0,
          height: 25.0,
          child: Text(
            text,
            style: TextStyle(
              color: isMyTrainingMate ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isMyTrainingMate ? Colors.white : Colors.blue,
            border: Border.all(
              color: isMyTrainingMate ? Colors.grey : Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text(isMyTrainingMate ? widget.ourPlayer.username+' is my Training mate': widget.ourPlayer.username+' is not my Training mate',),
        leading: buildChatButton(),),
      body:
      Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(alignment: Alignment.bottomCenter,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: Color(0x54FFFFFF),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageEditingController,
                          style: simpleTextStyle(),
                          decoration: InputDecoration(
                              hintText: "Message ...",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 16,
                              ),
                              border: InputBorder.none
                          ),
                        )),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight
                            ),
                            borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.send),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final String receiver;

  MessageTile({@required this.message, @required this.sendByMe,this.receiver});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
              ]
                  : [
                const Color(0xfff5a623),
                const Color(0xfff5a623),
              ],
            )
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}