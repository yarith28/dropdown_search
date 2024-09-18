import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future openMaterialBottomSheet(BuildContext context, Widget content, BottomSheetProps props) {
  return showBottomSheet(
    context: context,
    showDragHandle: props.showDragHandle,
    sheetAnimationStyle: props.sheetAnimationStyle,
    enableDrag: props.enableDrag,
    backgroundColor: props.backgroundColor,
    clipBehavior: props.clipBehavior,
    elevation: props.elevation,
    shape: props.shape,
    transitionAnimationController: props.transitionAnimationController,
    constraints: props.constraints,
    builder: (ctx) => content,
  ).closed;
}

Future openAdaptiveBottomSheet(BuildContext context, Widget content, BottomSheetProps props) {
  final ThemeData theme = Theme.of(context);
  switch (theme.platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return openCupertinoBottomSheet(context, content, props);
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
    default:
      return openMaterialBottomSheet(context, content, props);
  }
}

Future openCupertinoBottomSheet(BuildContext context, Widget content, BottomSheetProps props) {
  return showCupertinoModalPopup(
    context: context,
    builder: (ctx) => content,
  );
}
