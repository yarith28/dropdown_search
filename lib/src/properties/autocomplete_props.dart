import 'package:dropdown_search/src/base_dropdown_search.dart';
import 'package:dropdown_search/src/properties/menu_props.dart';
import 'package:flutter/material.dart';

class AutoCompleteProps {
  final MenuAlign? align;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? barrierColor;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final bool borderOnForeground;
  final String? barrierLabel;
  final PositionCallback? positionCallback;
  final Duration? reverseTransitionDuration;
  final Duration? transitionDuration;
  final Color? color;
  final String? semanticLabel;
  final Color? surfaceTintColor;
  final EdgeInsets? margin;
  final RouteTransitionsBuilder? transitionBuilder;

  const AutoCompleteProps({
    this.align,
    this.barrierLabel,
    this.elevation = 4,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
    this.positionCallback,
    this.barrierColor,
    this.backgroundColor,
    this.barrierDismissible = true,
    this.clipBehavior = Clip.none,
    this.borderOnForeground = false,
    this.borderRadius,
    this.shadowColor,
    this.color,
    this.transitionDuration,
    this.reverseTransitionDuration,
    this.semanticLabel,
    this.surfaceTintColor,
    this.margin,
    this.transitionBuilder,
  });
}

class CupertinoAutoCompleteProps<T> {
  final MenuAlign? align;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? barrierColor;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final bool borderOnForeground;
  final String? barrierLabel;
  final PositionCallback? positionCallback;
  final Duration? reverseTransitionDuration;
  final Duration? transitionDuration;
  final Color? color;
  final String? semanticLabel;
  final Color? surfaceTintColor;
  final EdgeInsets? margin;
  final RouteTransitionsBuilder? transitionBuilder;

  const CupertinoAutoCompleteProps({
    this.align,
    this.barrierLabel,
    this.elevation = 8,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    this.positionCallback,
    this.barrierColor,
    this.backgroundColor,
    this.barrierDismissible = true,
    this.clipBehavior = Clip.none,
    this.borderOnForeground = false,
    this.borderRadius,
    this.shadowColor,
    this.color,
    this.transitionDuration,
    this.reverseTransitionDuration,
    this.semanticLabel,
    this.surfaceTintColor,
    this.margin = const EdgeInsets.only(top: 8),
    this.transitionBuilder,
  });
}

class AdaptiveMenuProps {
  final CupertinoAutoCompleteProps cupertinoProps;
  final AutoCompleteProps materialProps;

  const AdaptiveMenuProps({
    this.materialProps = const AutoCompleteProps(),
    this.cupertinoProps = const CupertinoAutoCompleteProps(),
  });
}
