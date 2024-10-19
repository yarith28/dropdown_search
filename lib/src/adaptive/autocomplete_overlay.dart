import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/src/utils.dart';
import 'package:flutter/material.dart';

class CustomOverlyEntry {
  OverlayEntry? overlayEntry;
  Completer? completer;

  Future<void> open(BuildContext context, Widget child, TapRegionCallback? onTapOutside) async {
    if (completer?.isCompleted == false) return;

    completer = Completer();

    RelativeRect _position(RenderBox dropdown, RenderBox overlay) {
      var menuMinWidth = 0.0;
      var menuMaxWidth = double.infinity;

      var menuMinHeight = 0.0;
      var menuMaxHeight = double.infinity;

      var menuWidth = dropdown.size.width;
      var menuHeight = 350.0;

      if (menuMinWidth > 0) {
        menuWidth = menuMinWidth;
      }
      if (menuMaxWidth > 0 && menuMaxWidth < menuWidth) {
        menuWidth = menuMaxWidth;
      }

      if (menuMinHeight > 0) {
        menuHeight = menuMinHeight;
      }
      if (menuMaxHeight > 0 && menuMaxHeight < menuHeight) {
        menuHeight = menuMaxHeight;
      }

      return getPosition(dropdown, overlay, Size(menuWidth, menuHeight), MenuAlign.bottomEnd);
    }

    final dropdownBox = context.findRenderObject() as RenderBox;
    final overlayBox = Overlay.of(context).context.findRenderObject() as RenderBox;
    final pos = _position(dropdownBox, overlayBox);

    overlayEntry = OverlayEntry(builder: (context) {
      return Expanded(
        child: Positioned(
          top: pos.top+100,
          left: pos.left,
          right: pos.right,
          bottom: pos.bottom,
          child: Container(
            constraints: BoxConstraints(),
            child: TapRegion(
              groupId: 'salim',
              onTapOutside: onTapOutside,
              child: Material(
                elevation: PopupMenuTheme.of(context).elevation ?? 4,
                child: child,
                color: PopupMenuTheme.of(context).color,
              ),
            ),
          ),
        ),
      );
    });
    Overlay.of(context).insert(overlayEntry!);

    await completer?.future;
  }

  void close() {
    overlayEntry?.remove();
    overlayEntry = null;
    completer?.complete();
  }

  bool isOpen() => completer?.isCompleted == false;
}
