import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class StreamPlayerScreen extends StatefulWidget {
  final String streamUrl;
  final String title;

  const StreamPlayerScreen({super.key, required this.streamUrl, required this.title});

  @override
  State<StreamPlayerScreen> createState() => _StreamPlayerScreenState();
}

class _StreamPlayerScreenState extends State<StreamPlayerScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.streamUrl));
    try {
      await _videoController.initialize();
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoController,
          autoPlay: true,
          looping: false,
          aspectRatio: _videoController.value.aspectRatio,
        );
      });
    } catch (e) {
      setState(() => _error = true);
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: _error
            ? const Text('Could not load stream.', style: TextStyle(color: Colors.white))
            : _chewieController != null
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: Chewie(controller: _chewieController!),
                  )
                : const CircularProgressIndicator(),
      ),
    );
  }
}
