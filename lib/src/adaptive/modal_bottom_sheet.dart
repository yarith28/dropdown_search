import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future openMaterialModalBottomSheet(BuildContext context, Widget content, ModalBottomSheetProps props) {
  final sheetTheme = Theme.of(context).bottomSheetTheme;
  return showModalBottomSheet(
    context: context,
    barrierLabel: props.barrierLabel,
    scrollControlDisabledMaxHeightRatio: props.scrollControlDisabledMaxHeightRatio,
    showDragHandle: props.showDragHandle,
    sheetAnimationStyle: props.sheetAnimationStyle,
    useSafeArea: props.useSafeArea,
    barrierColor: props.barrierColor,
    backgroundColor: props.backgroundColor ?? sheetTheme.modalBackgroundColor ?? sheetTheme.backgroundColor ?? Colors.white,
    isDismissible: props.barrierDismissible,
    isScrollControlled: props.isScrollControlled,
    enableDrag: props.enableDrag,
    clipBehavior: props.clipBehavior,
    elevation: props.elevation,
    shape: props.shape,
    anchorPoint: props.anchorPoint,
    useRootNavigator: props.useRootNavigator,
    transitionAnimationController: props.animation,
    constraints: props.constraints,
    builder: (ctx) {
      return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: content,
      );
    },
  );
}

Future openAdaptiveModalBottomSheet(BuildContext context, Widget content, AdaptiveModalBottomSheetProps props) {
  final ThemeData theme = Theme.of(context);
  switch (theme.platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return openCupertinoModalBottomSheet(context, content, props.cupertinoProps);
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
    default:
      return openMaterialModalBottomSheet(context, content, props.materialProps);
  }
}

Future openCupertinoModalBottomSheet(BuildContext context, Widget content, CupertinoModalBottomSheetProps props) {
  return showCupertinoModalPopup(
    context: context,
    anchorPoint: props.anchorPoint,
    useRootNavigator: props.useRootNavigator,
    builder: (ctx) {
      return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: content,
      );
    },
  );
}
