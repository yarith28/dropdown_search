import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/src/utils.dart';
import 'package:flutter/material.dart';

abstract class CustomMenu<T> {
  final BuildContext context;

  CustomMenu({required this.context});

  Future<T?> openMenu() => Navigator.of(context).push(getRoute());

  Route<T> getRoute();
}

class MaterialCustomMenu<T> extends CustomMenu<T> {
  final MenuProps props;
  final Widget child;
  final BoxConstraints constraints;

  MaterialCustomMenu({required super.context, required this.props, required this.constraints, required this.child});

  @override
  Route<T> getRoute() {
    return _MaterialPopupMenuRoute<T>(
      parentContext: context,
      child: child,
      constraints: constraints,
      menuProps: props,
      capturedThemes: InheritedTheme.capture(
        from: context,
        to: Navigator.of(context).context,
      ),
    );
  }
}

class CupertinoCustomMenu<T> extends CustomMenu<T> {
  final CupertinoMenuProps props;
  final Widget child;
  final BoxConstraints constraints;

  CupertinoCustomMenu({required super.context, required this.constraints, required this.props, required this.child});

  @override
  Route<T> getRoute() {
    return _CupertinoPopupMenuRoute<T>(
      parentContext: context,
      child: child,
      constraints: constraints,
      menuProps: props,
      capturedThemes: InheritedTheme.capture(
        from: context,
        to: Navigator.of(context).context,
      ),
    );
  }
}

// Positioning of the menu on the screen.
class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;
  final BuildContext context;

  // The padding of unsafe area.
  EdgeInsets padding;

  _PopupMenuRouteLayout(
    this.context,
    this.padding,
    this.position,
  );

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    //keyBoardHeight is height of keyboard if showing
    double keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    double safeAreaTop = MediaQuery.of(context).padding.top;
    double safeAreaBottom = MediaQuery.of(context).padding.bottom;
    double safeAreaTotal = safeAreaTop + safeAreaBottom;

    return BoxConstraints.loose(
      Size(
        constraints.minWidth - position.left - position.right,
        constraints.minHeight,
      ),
    ).deflate(
      EdgeInsets.only(top: safeAreaTotal + keyBoardHeight) + padding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    //keyBoardHeight is height of keyboard if showing
    double keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;

    double x = position.left;

    // Find the ideal vertical position.
    double y = position.top;
    // check if we are in the bottom
    if (y + childSize.height > size.height - keyBoardHeight) {
      y = size.height - childSize.height - keyBoardHeight;
    } else if (y < 0) {
      y = 8;
    }

    if (x + childSize.width > size.width) {
      x = size.width - childSize.width;
    } else if (x < 0) {
      x = 8;
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    return true;
  }
}

class _MaterialPopupMenuRoute<T> extends PopupRoute<T> {
  final BoxConstraints constraints;
  final MenuProps menuProps; //for now menu props are the same for all uiModes
  final BuildContext parentContext;
  final Widget child;
  final CapturedThemes capturedThemes;

  _MaterialPopupMenuRoute({
    required this.menuProps,
    required this.parentContext,
    required this.constraints,
    required this.capturedThemes,
    required this.child,
  });

  @override
  Duration get transitionDuration => menuProps.transitionDuration ?? Duration.zero;

  @override
  Duration get reverseTransitionDuration => menuProps.reverseTransitionDuration ?? Duration.zero;

  @override
  bool get barrierDismissible => menuProps.barrierDismissible;

  @override
  Color? get barrierColor => menuProps.barrierColor;

  @override
  String? get barrierLabel => menuProps.barrierLabel;

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (menuProps.transitionBuilder != null) {
      return menuProps.transitionBuilder!(context, animation, secondaryAnimation, child);
    }
    return super.buildTransitions(context, animation, secondaryAnimation, child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final menu = Material(
      surfaceTintColor: menuProps.surfaceTintColor,
      shape: menuProps.shape ?? popupMenuTheme.shape,
      color: menuProps.backgroundColor ?? popupMenuTheme.color,
      type: MaterialType.card,
      elevation: menuProps.elevation ?? popupMenuTheme.elevation ?? 2.0,
      clipBehavior: menuProps.clipBehavior,
      borderRadius: menuProps.borderRadius,
      shadowColor: menuProps.shadowColor,
      borderOnForeground: menuProps.borderOnForeground,
      child: child,
    );
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    //handle menu margin
    // Here we get the render object of our physical button, later to get its size & position
    final dropdownBox = parentContext.findRenderObject() as RenderBox;
    // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
    var overlayBox = Overlay.of(parentContext).context.findRenderObject() as RenderBox;

    final RelativeRect pos;
    if (menuProps.positionCallback != null) {
      pos = menuProps.positionCallback!(dropdownBox, overlayBox).addMargin(menuProps.margin);
    } else {
      var popupSize = computePopupSize(dropdownBox, overlayBox, constraints);
      pos = getPosition(dropdownBox, overlayBox, popupSize, menuProps.align).addMargin(menuProps.margin);
    }

    return CustomSingleChildLayout(
      delegate: _PopupMenuRouteLayout(context, mediaQuery.padding, pos),
      child: capturedThemes.wrap(menu),
    );
  }
}

class _CupertinoPopupMenuRoute<T> extends PopupRoute<T> {
  final BoxConstraints constraints;
  final CupertinoMenuProps menuProps; //for now menu props are the same for all uiModes
  final BuildContext parentContext;
  final Widget child;
  final CapturedThemes capturedThemes;

  _CupertinoPopupMenuRoute({
    required this.menuProps,
    required this.parentContext,
    required this.constraints,
    required this.capturedThemes,
    required this.child,
  });

  @override
  Duration get transitionDuration => menuProps.transitionDuration ?? Duration.zero;

  @override
  Duration get reverseTransitionDuration => menuProps.reverseTransitionDuration ?? Duration.zero;

  @override
  bool get barrierDismissible => menuProps.barrierDismissible;

  @override
  Color? get barrierColor => menuProps.barrierColor;

  @override
  String? get barrierLabel => menuProps.barrierLabel;

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (menuProps.transitionBuilder != null) {
      return menuProps.transitionBuilder!(context, animation, secondaryAnimation, child);
    }
    return super.buildTransitions(context, animation, secondaryAnimation, child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final menu = Material(
      surfaceTintColor: menuProps.surfaceTintColor,
      shape: menuProps.shape ?? popupMenuTheme.shape,
      color: menuProps.backgroundColor ?? popupMenuTheme.color,
      type: MaterialType.card,
      elevation: menuProps.elevation ?? popupMenuTheme.elevation ?? 2.0,
      clipBehavior: menuProps.clipBehavior,
      borderRadius: menuProps.borderRadius,
      shadowColor: menuProps.shadowColor,
      borderOnForeground: menuProps.borderOnForeground,
      child: child,
    );
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    //handle menu margin
    // Here we get the render object of our physical button, later to get its size & position
    final dropdownBox = parentContext.findRenderObject() as RenderBox;
    // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
    var overlayBox = Overlay.of(parentContext).context.findRenderObject() as RenderBox;

    final RelativeRect pos;
    if (menuProps.positionCallback != null) {
      pos = menuProps.positionCallback!(dropdownBox, overlayBox).addMargin(menuProps.margin);
    } else {
      var popupSize = computePopupSize(dropdownBox, overlayBox, constraints);
      pos = getPosition(dropdownBox, overlayBox, popupSize, menuProps.align).addMargin(menuProps.margin);
    }

    return CustomSingleChildLayout(
      delegate: _PopupMenuRouteLayout(context, mediaQuery.padding, pos),
      child: capturedThemes.wrap(menu),
    );
  }
}
