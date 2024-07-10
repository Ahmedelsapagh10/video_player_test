import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreenFile extends StatefulWidget {
  String? videoFile;
  VideoPlayerScreenFile({required this.videoFile, super.key});
  @override
  _VideoPlayerScreenFileState createState() => _VideoPlayerScreenFileState();
}

class _VideoPlayerScreenFileState extends State<VideoPlayerScreenFile> {
  VideoPlayerController? _controller;
  Future<void> _pickVideo() async {
    if (widget.videoFile != null) {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoFile ?? ''),
      )..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
    }
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
