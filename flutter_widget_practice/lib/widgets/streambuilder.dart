import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';

class StreambuilderWidget extends StatefulWidget {
  const StreambuilderWidget({super.key});

  @override
  State<StreambuilderWidget> createState() => _StreambuilderWidgetState();
}

class _StreambuilderWidgetState extends State<StreambuilderWidget> {
  List<String> chatlist = [];
  StreamSocket streamSocket = StreamSocket();
  TextEditingController chatController = TextEditingController();

  Stream<int> streamfunc() async* {
    while (true) {
      await Future.delayed(
        const Duration(seconds: 1),
      );
      yield DateTime.now().second;
    }
  }

  @override
  void initState() {
    super.initState();
    streamSocket.addResponse(chatlist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: streamSocket.getResponse,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.done ||
                        snapshot.connectionState == ConnectionState.active) {
                      return ListView.builder(
                        itemCount: chatlist.length,
                        itemBuilder: (context, index) {
                          return text(snapshot.data![index].toString(),
                              fontsize: 20);
                        },
                      );
                    } else {
                      return Text(snapshot.connectionState.toString());
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: chatController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Type Message',
                        ),
                      ),
                    ),
                    IconButton( 
                      onPressed: () {
                        chatlist.add(chatController.text);
                        streamSocket.addResponse(chatlist);
                        chatController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StreamSocket {
  final _stream = StreamController<List<String>>.broadcast();

  void Function(List<String>) get addResponse => _stream.sink.add;

  Stream<List<String>> get getResponse => _stream.stream.asBroadcastStream();
}
