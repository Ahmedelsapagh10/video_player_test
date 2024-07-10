import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerNetWorkScreen extends StatefulWidget {
  const VideoPlayerNetWorkScreen({required this.link, super.key});
  final String link;

  @override
  State<VideoPlayerNetWorkScreen> createState() =>
      _VideoPlayerNetWorkScreenState();
}

class _VideoPlayerNetWorkScreenState extends State<VideoPlayerNetWorkScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  Future<void> _playVideo() async {
    if (widget.link.isNotEmpty) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.link));
      await _controller.initialize();
      _controller.play();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _playVideo().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: false,
        looping: false,
        materialProgressColors: ChewieProgressColors(
          backgroundColor: Colors.grey,
          playedColor: Colors.red,
        ),
        cupertinoProgressColors: ChewieProgressColors(
          backgroundColor: Colors.grey,
          playedColor: Colors.red,
        ),
      );
    });
  }

  Widget _buildVideo() {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio ?? 16 / 9,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  Widget _buildLoading() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset('assets/images/10.png'),
        ),
        const CircularProgressIndicator(
          color: Colors.red,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized ? _buildVideo() : _buildLoading(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
