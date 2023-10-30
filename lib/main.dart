import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

import 'config/stream_config.dart';
import 'home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureStream();
  runApp(const MyApp());
}



Future<void> configureStream()async{
  print('Configuring stream...');
  final value = StreamVideo(LiveStreamConfig.apiKey,
  user:  User(
    info: UserInfo(
      id: DateTime.now().toIso8601String(),
      name: 'test user',
    ),
    type: UserType.guest,
  ));
  value.events.listen((event) {
    print(event);
    print(event.props);
  });
  print('stream configured ${value.currentUser}');
  //   await StreamVideo.instance
  //       .connect();
  // StreamBackgroundService.init(
  //   StreamVideo.instance,
  //   onNotificationClick: (call) async {
  //    print( '[onNotificationClick] call: $call');
  //   },
  //   onPlatformUiLayerDestroyed: (call) async {
  //     print('[onPlatformUiLayerDestroyed] call: $call');
  //   },
  // );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live stream example',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Live stream demo app'),
    );
  }
}

