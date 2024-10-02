import 'package:flutter/material.dart';

///see [IconButton] props for more details
class IconButtonProps {
  final double iconSize;
  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final double? splashRadius;
  final Widget? icon;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? color;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? disabledColor;
  final MouseCursor mouseCursor;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? tooltip;
  final bool enableFeedback;
  final BoxConstraints? constraints;
  final bool isVisible;
  final ButtonStyle? style;
  final bool? isSelected;
  final Widget? selectedIcon;

  const IconButtonProps({
    this.icon,
    this.isVisible = false,
    this.iconSize = 24.0,
    this.visualDensity,
    this.padding = const EdgeInsets.all(8.0),
    this.alignment = Alignment.center,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.mouseCursor = SystemMouseCursors.click,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback = false,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
  }) : assert(splashRadius == null || splashRadius > 0);

  IconButtonProps copyWith({
    double? iconSize,
    VisualDensity? visualDensity,
    EdgeInsetsGeometry? padding,
    AlignmentGeometry? alignment,
    double? splashRadius,
    Widget? icon,
    Color? focusColor,
    Color? hoverColor,
    Color? color,
    Color? splashColor,
    Color? highlightColor,
    Color? disabledColor,
    MouseCursor? mouseCursor,
    FocusNode? focusNode,
    bool? autofocus,
    String? tooltip,
    bool? enableFeedback,
    BoxConstraints? constraints,
    bool? isVisible,
    ButtonStyle? style,
    bool? isSelected,
    Widget? selectedIcon,
  }) {
    return IconButtonProps(
      iconSize: iconSize ?? this.iconSize,
      visualDensity: visualDensity ?? this.visualDensity,
      padding: padding ?? this.padding,
      alignment: alignment ?? this.alignment,
      splashRadius: splashRadius ?? this.splashRadius,
      icon: icon ?? this.icon,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      color: color ?? this.color,
      splashColor: splashColor ?? this.splashColor,
      highlightColor: highlightColor ?? this.highlightColor,
      disabledColor: disabledColor ?? this.disabledColor,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      focusNode: focusNode ?? this.focusNode,
      autofocus: autofocus ?? this.autofocus,
      tooltip: tooltip ?? this.tooltip,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      constraints: constraints ?? this.constraints,
      isVisible: isVisible ?? this.isVisible,
      style: style ?? this.style,
      isSelected: isSelected ?? this.isSelected,
      selectedIcon: selectedIcon ?? this.selectedIcon,
    );
  }

  IconButtonProps merge(IconButtonProps? other) {
    if (other == null) return this;

    return copyWith(
      iconSize: other.iconSize,
      visualDensity: other.visualDensity,
      padding: other.padding,
      alignment: other.alignment,
      splashRadius: other.splashRadius,
      icon: other.icon,
      focusColor: other.focusColor,
      hoverColor: other.hoverColor,
      color: other.color,
      splashColor: other.splashColor,
      highlightColor: other.highlightColor,
      disabledColor: other.disabledColor,
      mouseCursor: other.mouseCursor,
      focusNode: other.focusNode,
      autofocus: other.autofocus,
      tooltip: other.tooltip,
      enableFeedback: other.enableFeedback,
      constraints: other.constraints,
      isVisible: other.isVisible,
      style: other.style,
      isSelected: other.isSelected,
      selectedIcon: other.selectedIcon,
    );
  }
}
