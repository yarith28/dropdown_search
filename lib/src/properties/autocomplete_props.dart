import 'package:dropdown_search/src/base_dropdown_search.dart';
import 'package:dropdown_search/src/properties/menu_props.dart';
import 'package:flutter/material.dart';

class AutocompleteProps {
  final MenuAlign? align;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? backgroundColor;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final bool borderOnForeground;
  final PositionCallback? positionCallback;
  final Color? color;
  final Color? surfaceTintColor;
  final EdgeInsets? margin;

  const AutocompleteProps({
    this.align,
    this.elevation = 4,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
    this.positionCallback,
    this.backgroundColor,
    this.clipBehavior = Clip.none,
    this.borderOnForeground = false,
    this.borderRadius,
    this.shadowColor,
    this.color,
    this.surfaceTintColor,
    this.margin,
  });
}

class CupertinoAutocompleteProps<T> {
  final MenuAlign? align;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? backgroundColor;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final bool borderOnForeground;
  final PositionCallback? positionCallback;
  final Color? color;
  final Color? surfaceTintColor;
  final EdgeInsets? margin;

  const CupertinoAutocompleteProps({
    this.align,
    this.elevation = 8,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    this.positionCallback,
    this.backgroundColor,
    this.clipBehavior = Clip.none,
    this.borderOnForeground = false,
    this.borderRadius,
    this.shadowColor,
    this.color,
    this.surfaceTintColor,
    this.margin = const EdgeInsets.only(top: 8),
  });
}

class AdaptiveAutocompleteProps {
  final CupertinoAutocompleteProps cupertinoProps;
  final AutocompleteProps materialProps;

  const AdaptiveAutocompleteProps({
    this.materialProps = const AutocompleteProps(),
    this.cupertinoProps = const CupertinoAutocompleteProps(),
  });
}
