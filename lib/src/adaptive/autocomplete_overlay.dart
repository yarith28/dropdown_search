import 'dart:async';

import 'package:dropdown_search/src/properties/autocomplete_props.dart';
import 'package:dropdown_search/src/utils.dart';
import 'package:flutter/material.dart';

abstract class CustomOverlayEntry {
  OverlayEntry? overlayEntry;
  Completer? completer;

  OverlayEntry getOverlayEntry(BuildContext context);

  void close() {
    overlayEntry?.remove();
    overlayEntry = null;
    completer?.complete();
  }

  Future<void> open(BuildContext context) async {
    if (completer?.isCompleted == false) return;

    completer = Completer();

    overlayEntry = getOverlayEntry(context);

    Overlay.of(context).insert(overlayEntry!);

    await completer?.future;
  }

  bool isOpen() => completer?.isCompleted == false;
}

class MaterialCustomOverlyEntry extends CustomOverlayEntry {
  final AutoCompleteProps props;
  final BoxConstraints constraints;
  final TapRegionCallback? onTapOutside;
  final Widget? child;

  MaterialCustomOverlyEntry({required this.props, required this.constraints, this.child, this.onTapOutside});

  @override
  getOverlayEntry(BuildContext context) {
    final dropdownBox = context.findRenderObject() as RenderBox;
    final overlayBox = Overlay.of(context).context.findRenderObject() as RenderBox;
    final dropdownSize = computePopupSize(dropdownBox, overlayBox, constraints);
    final pos = getPosition(dropdownBox, overlayBox, dropdownSize, props.align);

    return OverlayEntry(builder: (context) {
      return Positioned(
        top: pos.top,
        left: pos.left,
        right: pos.right,
        bottom: pos.bottom,
        child: Container(
          constraints: constraints,
          child: TapRegion(
            groupId: 'salim',
            onTapOutside: onTapOutside,
            child: Material(
              type: MaterialType.card,
              shape: props.shape ?? PopupMenuTheme.of(context).shape,
              elevation: props.elevation ?? PopupMenuTheme.of(context).elevation ?? 4,
              color: props.color ?? PopupMenuTheme.of(context).color,
              clipBehavior: props.clipBehavior,
              borderRadius: props.borderRadius,
              shadowColor: props.shadowColor,
              borderOnForeground: props.borderOnForeground,
              surfaceTintColor: props.surfaceTintColor,
              child: child,
            ),
          ),
        ),
      );
    });
  }
}

class CupertinoCustomOverlyEntry extends CustomOverlayEntry {
  final CupertinoAutoCompleteProps props;
  final TapRegionCallback? onTapOutside;
  final BoxConstraints constraints;
  final Widget? child;

  CupertinoCustomOverlyEntry({required this.props, required this.constraints, this.child, this.onTapOutside});

  @override
  OverlayEntry getOverlayEntry(BuildContext context) {
    final dropdownBox = context.findRenderObject() as RenderBox;
    final overlayBox = Overlay.of(context).context.findRenderObject() as RenderBox;
    final dropdownSize = computePopupSize(dropdownBox, overlayBox, BoxConstraints());
    final pos = getPosition(dropdownBox, overlayBox, dropdownSize, props.align);

    return OverlayEntry(builder: (context) {
      return Expanded(
        child: Positioned(
          top: pos.top,
          left: pos.left,
          right: pos.right,
          bottom: pos.bottom,
          child: Container(
            constraints: BoxConstraints(),
            child: TapRegion(
              groupId: 'salim',
              onTapOutside: onTapOutside,
              child: Material(
                animationDuration: Duration(seconds: 1),
                type: MaterialType.card,
                shape: props.shape ?? PopupMenuTheme.of(context).shape,
                elevation: props.elevation ?? PopupMenuTheme.of(context).elevation ?? 8,
                color: props.color ?? PopupMenuTheme.of(context).color,
                clipBehavior: props.clipBehavior,
                borderRadius: props.borderRadius,
                shadowColor: props.shadowColor,
                borderOnForeground: props.borderOnForeground,
                surfaceTintColor: props.surfaceTintColor,
                child: child,
              ),
            ),
          ),
        ),
      );
    });
  }
}
