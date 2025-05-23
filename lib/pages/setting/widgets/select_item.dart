import 'package:PiliPlus/models/common/video/audio_quality.dart';
import 'package:PiliPlus/models/common/video/video_decode_type.dart';
import 'package:PiliPlus/models/common/video/video_quality.dart';
import 'package:PiliPlus/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SetSelectItem extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final String? setKey;
  const SetSelectItem({
    this.title,
    this.subTitle,
    this.setKey,
    super.key,
  });

  @override
  State<SetSelectItem> createState() => _SetSelectItemState();
}

class _SetSelectItemState extends State<SetSelectItem> {
  late dynamic currentVal;
  late int currentIndex;
  late List menus;
  late List<PopupMenuEntry> popMenuItems;

  Box get setting => GStorage.setting;

  @override
  void initState() {
    super.initState();
    late String defaultVal;
    switch (widget.setKey) {
      case 'defaultVideoQa':
        defaultVal = VideoQuality.values.last.description;
        List<VideoQuality> list = menus = VideoQuality.values.reversed.toList();
        currentVal = setting.get(widget.setKey, defaultValue: defaultVal);
        currentIndex =
            list.firstWhere((i) => i.description == currentVal).index;

        popMenuItems = [
          for (var i in list) ...[
            PopupMenuItem(
              value: i.code,
              child: Text(i.description),
            )
          ]
        ];

        break;
      case 'defaultAudioQa':
        defaultVal = AudioQuality.values.last.description;
        List<AudioQuality> list = menus = AudioQuality.values.reversed.toList();
        currentVal = setting.get(widget.setKey, defaultValue: defaultVal);
        currentIndex =
            list.firstWhere((i) => i.description == currentVal).index;

        popMenuItems = [
          for (var i in list) ...[
            PopupMenuItem(
              value: i.index,
              child: Text(i.description),
            ),
          ]
        ];
        break;
      case 'defaultDecode':
        defaultVal = VideoDecodeFormatType.values[0].description;
        currentVal = setting.get(widget.setKey, defaultValue: defaultVal);
        List<VideoDecodeFormatType> list = menus = VideoDecodeFormatType.values;

        currentIndex =
            list.firstWhere((i) => i.description == currentVal).index;

        popMenuItems = [
          for (var i in list) ...[
            PopupMenuItem(
              value: i.index,
              child: Text(i.description),
            ),
          ]
        ];
        break;
      case 'defaultVideoSpeed':
        defaultVal = '1.0';
        currentVal = setting.get(widget.setKey, defaultValue: defaultVal);

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TextStyle subTitleStyle =
        theme.textTheme.labelMedium!.copyWith(color: theme.colorScheme.outline);
    return ListTile(
      onTap: () {},
      title: Text(widget.title!),
      subtitle: Text(
        '当前${widget.title!} $currentVal',
        style: subTitleStyle,
      ),
      trailing: PopupMenuButton(
        initialValue: currentIndex,
        icon: const Icon(
          Icons.arrow_forward_rounded,
          size: 22,
        ),
        onSelected: (item) {
          currentVal = menus.firstWhere((e) => e.code == item).first;
          setState(() {});
        },
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry>[...popMenuItems],
      ),
    );
  }
}
