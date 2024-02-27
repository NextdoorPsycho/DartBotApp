import 'package:nyxx/nyxx.dart';

class EChannel {
  final Snowflake id;
  final String name;
  final ChannelType type;
  final Snowflake? parentId;
  final int position;
  List<EChannel>? children;

  EChannel({
    required this.id,
    required this.name,
    required this.type,
    this.parentId,
    required this.position,
    this.children,
  });

  // Helper method to convert from GuildChannel
  factory EChannel.fromGuildChannel(GuildChannel channel) {
    return EChannel(
      id: channel.id,
      name: channel.name,
      type: channel.type,
      parentId: channel.parentId,
      position: channel.position,
    );
  }

  // Method to add a child channel
  void addChild(EChannel channel) {
    children ??= [];
    children!.add(channel);
  }

  // Method to sort children by position and type
  void sortChildren() {
    children?.sort((a, b) {
      int typeComparison = _compareChannelType(a.type, b.type);
      if (typeComparison != 0) return typeComparison;
      return a.position.compareTo(b.position);
    });
  }

  static int _compareChannelType(ChannelType aType, ChannelType bType) {
    if (aType == bType) return 0;
    if (aType == ChannelType.guildText) return -1;
    if (bType == ChannelType.guildText) return 1;
    // Add more comparison logic if needed
    return 0;
  }
}
