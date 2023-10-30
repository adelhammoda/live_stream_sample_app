import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import 'live_stream_ui.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _streamIdController = TextEditingController();

  Future<void> createLiveStream() async {
    print("creating call");
    final call = StreamVideo.instance.makeCall(
      type: 'livestream',
      id: '123123',
    );
    print(" call created with id: $call");
    print('connection a call ');
    // Set some default behaviour for how our devices should be configured once we join a call
    call.connectOptions = CallConnectOptions(
      camera: TrackOption.enabled(),
      microphone: TrackOption.enabled(),
    );
    call.setCameraEnabled(enabled: true);
    call.setMicrophoneEnabled(enabled: true);

    print('get or create function');
    final result = await call.getOrCreate(); // Call object is created
    print("get or create result: $result");
    print(result.isSuccess);
    if (result.isSuccess) {
      await call.join(); // Our local app user is able to join and recieve events from the call
    await call.goLive(); // Allow others to see and joing the call
    print('Joining call ${call.id}');
    Navigator.of(context).push(LiveStreamScreen.route(call));
    } else {
      print('Not able to create a call.');
    }
  }

  void joinLiveStream() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _streamIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter stream id',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: createLiveStream,
              child: const Text("Create live stream"),
            ),
            ElevatedButton(
              onPressed: joinLiveStream,
              child: const Text("Join live stream"),
            ),
          ],
        ),
      ),

    );
  }
}
