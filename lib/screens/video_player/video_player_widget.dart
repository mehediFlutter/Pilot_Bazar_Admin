import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late List<VideoPlayerController> videoPlayerControllers;
  late List<ChewieController> chewieControllers;

  final List<String> videoUrls = [
    'https://res.cloudinary.com/dabwsqaxs/video/upload/v1729701990/reel/1gg0ugBaaBqcu7HaSkM3tiGIn8g6ik2mWXlMlBEB.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // Add more video URLs here
  ];

  @override
  void initState() {
    super.initState();
    videoPlayerControllers = [];
    chewieControllers = [];

    for (var url in videoUrls) {
      var controller = VideoPlayerController.networkUrl(Uri.parse(url));
      var chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        looping: true,
      );

      videoPlayerControllers.add(controller);
      chewieControllers.add(chewieController);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in videoPlayerControllers) {
      controller.dispose();
    }
    for (var chewieController in chewieControllers) {
      chewieController.dispose();
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification) {
              final index = (scrollNotification.metrics.pixels /
                      MediaQuery.of(context).size.height)
                  .round();
              if (index >= 0 && index < chewieControllers.length) {
                for (int i = 0; i < chewieControllers.length; i++) {
                  if (i == index) {
                    chewieControllers[i].play();
                  } else {
                    chewieControllers[i].pause();
                  }
                }
                setState(() {});
              }
            }
            return true;
          },
          child: ListView.builder(
            itemCount: videoUrls.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.1,
                child: Chewie(
                  controller: chewieControllers[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
