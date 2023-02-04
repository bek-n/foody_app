import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class CustomVideo extends StatefulWidget {
  final bool isOwner;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String videoUrl;

  const CustomVideo({
    Key? key,
    required this.videoUrl,
    required this.isOwner,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomVideoState createState() => _CustomVideoState();
}

class _CustomVideoState extends State<CustomVideo> {
  late VideoPlayerController _controller;
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurSize: 10,
      duration: const Duration(milliseconds: 300),
      onPressed: () {},
      menuItems: widget.isOwner
          ? [
             
              FocusedMenuItem(
                  title: const Text("Delete"), onPressed: widget.onDelete),
            ]
          : [
              FocusedMenuItem(
                  title: const Text("Delete"), onPressed: widget.onDelete),
            ],
      child: CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController),
    );
  }

  @override
  void deactivate() {
    // _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _customVideoPlayerController.dispose();
    // _controller.dispose();
  }
}
