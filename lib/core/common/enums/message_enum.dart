enum MessageEnum {
  TEXT('text'),
  IMAGE('image'),
  AUDIO('audio'),
  VIDEO('video'),
  GIF('gif');

  const MessageEnum(this.type);
  final String type;
}

extension ConvertMessage on String {
  MessageEnum toEnum() {
    switch (this) {
      case "audio":
        return MessageEnum.AUDIO;
      case "image":
        return MessageEnum.IMAGE;
      case "gif":
        return MessageEnum.GIF;
      case "text":
        return MessageEnum.TEXT;
      case "video":
        return MessageEnum.VIDEO;
      default:
        return MessageEnum.TEXT;
    }
  }
}
