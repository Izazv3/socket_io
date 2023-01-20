import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket/controller/home.dart';
import 'package:socket/model.dart';
import 'package:socket/mychat.dart';
import 'package:socket/others_chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class LandingPage extends StatefulWidget {
  final String username;
  final String userid;
  const LandingPage({Key? key, required this.username, required this.userid})
      : super(key: key);
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late io.Socket _socket;
  final TextEditingController _messageInputController = TextEditingController();
  var i = 0;
  sendMessage() {
    Message myMessage = Message(
        message: _messageInputController.text,
        senderUsername: widget.username,
        type: 'mymessage');
    controller.addNewMessage(myMessage);
    setState(() {
      controller.listmessages;
    });
    _socket.emit('sendMsg', {
      'message': _messageInputController.text.trim(),
      'sender': widget.username,
      'type': 'mymessage',
      'userid': widget.userid
    });

    _messageInputController.clear();
  }

  _connectSocket() {
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));

    // _socket.on('timer', (data) {
    //   controller.couter.value = data;
    //   print(data);
    // });
    _socket.on('sendMsgServer', (message) {
      //controller.couter.value = data;
      print("************************* ${message}");
      //if (message["userid"] != widget.userid)
      {
        setState(() {
          controller.addNewMessage(message);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    _socket = io.io(
        'https://izazv3-refactored-space-barnacle-xqgj5qjxg96f97wv-5000.preview.app.github.dev',
        <String, dynamic>{
          "transports": ["websocket"],
          "autoconnect": false,
        }
        // io.OptionBuilder().setTransports(['websocket']).setQuery(
        //     {'username': widget.username}).build(),
        );
    _connectSocket();
    //_socket.emit('hello', '24');
  }

  @override
  void dispose() {
    _socket.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket message"),
        centerTitle: true,
      ),
      body:
          // Obx(
          //   () =>
          Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: controller.listmessages.length,
                  itemBuilder: (context, index) {
                    if (controller.listmessages[index].type == "mymessage") {
                      return MyChat(
                          username:
                              controller.listmessages[index].senderUsername,
                          message: controller.listmessages[index].message);
                    } else {
                      return OthersChat(
                          username:
                              controller.listmessages[index].senderUsername,
                          message: controller.listmessages[index].message);
                    }
                  }
                  // children: controller.messages
                  //     .map((e) => MyChat(
                  //         username: widget.username,
                  //         message: '${controller.messages}'))
                  //     .toList()
                  )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextFormField(
              controller: _messageInputController,
              decoration: InputDecoration(
                  hintText: 'Type here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (_messageInputController.text.isNotEmpty) {
                          sendMessage();
                        }
                      },
                      icon: Icon(Icons.send))),
            ),
          )
        ],
      ),
      //)
    );
  }
}
