import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/src/utils.dart';
import 'package:flutter/material.dart';

Future<T?> openMenu<T>({
  required BuildContext parentContext,
  required BasePopupProps<T> props,
  required dynamic menuProps,
  required Widget child,
}) {
  final NavigatorState navigator = Navigator.of(parentContext);
  return navigator.push(
    _PopupMenuRoute<T>(
      parentContext: parentContext,
      child: child,
      popupProps: props,
      menuProps: menuProps,
      capturedThemes: InheritedTheme.capture(
        from: parentContext,
        to: navigator.context,
      ),
    ),
  );
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

class _PopupMenuRoute<T> extends PopupRoute<T> {
  final BasePopupProps<T> popupProps;
  final dynamic menuProps; //for now menu props are the same for all uiModes
  final BuildContext parentContext;
  final Widget child;
  final CapturedThemes capturedThemes;

  _PopupMenuRoute({
    required this.menuProps,
    required this.parentContext,
    required this.popupProps,
    required this.capturedThemes,
    required this.child,
  });

  @override
  Duration get transitionDuration => menuProps.transitionDuration ?? Duration(milliseconds: 200);

  @override
  Duration get reverseTransitionDuration => menuProps.reverseTransitionDuration ?? Duration(milliseconds: 200);

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
      elevation: menuProps.elevation ?? popupMenuTheme.elevation ?? 8.0,
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

    var pos = (menuProps.positionCallback ?? _position)(dropdownBox, overlayBox);
    if (menuProps.margin != null) {
      final margin = menuProps.margin!;
      pos = RelativeRect.fromLTRB(
        pos.left + margin.left,
        pos.top + margin.top,
        pos.right + margin.right,
        pos.bottom + margin.bottom,
      );
    }

    return CustomSingleChildLayout(
      delegate: _PopupMenuRouteLayout(context, mediaQuery.padding, pos),
      child: capturedThemes.wrap(menu),
    );
  }

  ///the goal of this function is to return a position of the popup
  ///taking in consideration menu button width and popup constraints
  RelativeRect _position(RenderBox dropdown, RenderBox overlay) {
    var menuMinWidth = popupProps.constraints.minWidth;
    var menuMaxWidth = popupProps.constraints.maxWidth;

    var menuMinHeight = popupProps.constraints.minHeight;
    var menuMaxHeight = popupProps.constraints.maxHeight;

    var menuWidth = dropdown.size.width;
    var menuHeight = 350.0;

    if (menuMinWidth > 0) {
      menuWidth = menuMinWidth;
    }
    if (menuMaxWidth > 0 && menuMaxWidth < menuWidth) {
      menuWidth = menuMaxWidth;
    }
    if (dropdown.size.width < 64) {
      menuWidth = 180;
    }

    if (menuMinHeight > 0) {
      menuHeight = menuMinHeight;
    }
    if (menuMaxHeight > 0 && menuMaxHeight < menuHeight) {
      menuHeight = menuMaxHeight;
    }

    return getPosition(dropdown, overlay, Size(menuWidth, menuHeight), menuProps.align);
  }
}
