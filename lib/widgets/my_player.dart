import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const MyPlayerPreviewApp());

class MyPlayerPreviewApp extends StatelessWidget {
  const MyPlayerPreviewApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String mediaUrl = 'https://m4strssl.ebse.co.kr/2021/er2017h0spe01zz/1m/20210809_063000_243250eb_m10.mp4';
    // const String mediaUrl = 'https://docs.google.com/uc?export=open&id=1FxG1F0lBR8zkMfeLDpmF0LoNfQpTy5Me';

    return MaterialApp(
      title: "MyPlayer Preview",
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MyPlayer Preview'),
        ),
        body: const MyPlayer(url: mediaUrl),
      ),
    );
  }
}

/// Stateful widget to fetch and then display video content.
class MyPlayer extends StatefulWidget {
  final String url;

  const MyPlayer({Key? key, required this.url}) : super(key: key);

  @override
  State<MyPlayer> createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  var _aspectRatio = 1.0;
  double? _width = null;
  double? _height = null;
  late double _deviceHeight, _deviceWidth;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.url);
    await _videoPlayerController.initialize();
    _aspectRatio = _videoPlayerController.value.aspectRatio;
    print('_videoPlayerController.value.aspectRatio: ${_videoPlayerController.value.aspectRatio}');
    print('_videoPlayerController.value.size.aspectRatio: ${_videoPlayerController.value.size.aspectRatio}');
    print('_videoPlayerController.value.size: ${_videoPlayerController.value.size}');
    _width = _videoPlayerController.value.size.width;
    _height = _videoPlayerController.value.size.height;
    if (_width == 0) { // audio case
      _width = _deviceWidth;
      _height = 200;
    }

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return ColoredBox(
      color: Colors.black,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          height: _height ?? 200,
          width: _width ?? _deviceWidth,
          child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(controller: _chewieController!)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    Row(
                      children: const [Expanded(child: Text('Loading'))],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
