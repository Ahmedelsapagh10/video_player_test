import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenAsset extends StatefulWidget {
  VideoPlayerScreenAsset({super.key});
  @override
  _VideoPlayerScreenAssetState createState() => _VideoPlayerScreenAssetState();
}

class _VideoPlayerScreenAssetState extends State<VideoPlayerScreenAsset> {
  VideoPlayerController? _controller;
  Future<void> _pickVideo() async {
    _controller = VideoPlayerController.asset('assets/images/video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }

  @override
  void initState() {
    _pickVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: _controller != null && _controller!.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(
                  _controller!,
                ),
              )
            : Image.asset('assets/images/10.png'),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
