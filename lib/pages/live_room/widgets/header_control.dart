import 'dart:io';

import 'package:PiliPlus/plugin/pl_player/controller.dart';
import 'package:PiliPlus/utils/page_utils.dart';
import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LiveHeaderControl extends StatelessWidget {
  const LiveHeaderControl({
    required this.plPlayerController,
    required this.onSendDanmaku,
    super.key,
  });

  final PlPlayerController plPlayerController;
  final VoidCallback onSendDanmaku;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      primary: false,
      automaticallyImplyLeading: false,
      titleSpacing: 14,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 42,
            height: 34,
            child: IconButton(
              tooltip: '发弹幕',
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero),
              ),
              onPressed: onSendDanmaku,
              icon: const Icon(
                Icons.comment_outlined,
                size: 19,
                color: Colors.white,
              ),
            ),
          ),
          Obx(
            () => IconButton(
              onPressed: plPlayerController.setOnlyPlayAudio,
              icon: plPlayerController.onlyPlayAudio.value
                  ? const Icon(
                      size: 18,
                      MdiIcons.musicCircle,
                      color: Colors.white,
                    )
                  : const Icon(
                      size: 18,
                      MdiIcons.musicCircleOutline,
                      color: Colors.white,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          if (Platform.isAndroid) ...[
            SizedBox(
              width: 34,
              height: 34,
              child: IconButton(
                tooltip: '画中画',
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () async {
                  try {
                    var floating = Floating();
                    if ((await floating.isPipAvailable) == true) {
                      plPlayerController.hiddenControls(false);
                      floating.enable(
                        plPlayerController.direction.value == 'vertical'
                            ? const EnableManual(
                                aspectRatio: Rational.vertical())
                            : const EnableManual(),
                      );
                    }
                  } catch (_) {}
                },
                icon: const Icon(
                  Icons.picture_in_picture_outlined,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
          IconButton(
            onPressed: () => PageUtils.scheduleExit(
              context,
              plPlayerController.isFullScreen.value,
              true,
            ),
            icon: const Icon(
              size: 18,
              Icons.schedule,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
