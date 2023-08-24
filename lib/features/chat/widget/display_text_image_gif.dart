import 'package:cached_network_image/cached_network_image.dart';
import 'package:whatsapp/core/common/enums/message_enum.dart';
import 'package:whatsapp/exports.dart';

class DisplayTextImageGIF extends ConsumerStatefulWidget {
  final String message;
  final MessageEnum type;

  const DisplayTextImageGIF(
      {super.key, required this.message, required this.type});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DisplayTextImageGIFState();
}

class _DisplayTextImageGIFState extends ConsumerState<DisplayTextImageGIF> {
  @override
  Widget build(BuildContext context) {
    return widget.type == MessageEnum.TEXT
        ? Text(
            widget.message,
            style: const TextStyle(fontSize: 16),
          )
        : CachedNetworkImage(imageUrl: widget.message);
  }
}
