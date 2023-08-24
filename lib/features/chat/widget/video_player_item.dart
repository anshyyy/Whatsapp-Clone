import 'package:whatsapp/exports.dart';

class VideoPlayerItem extends ConsumerStatefulWidget {
  const VideoPlayerItem({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends ConsumerState<VideoPlayerItem> {
  late CachedVideoPlayer
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 16/9,

    child: Stack(
      children: [
        CachedVideoPlayer()
      ],
    ),
    );
  }
}