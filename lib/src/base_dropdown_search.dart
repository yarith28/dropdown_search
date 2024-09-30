import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/src/adaptive/bottom_sheets.dart';
import 'package:dropdown_search/src/adaptive/modal_bottom_sheet.dart';
import 'package:dropdown_search/src/properties/adaptive_popup_props.dart';
import 'package:dropdown_search/src/properties/chip_props.dart';
import 'package:dropdown_search/src/properties/cupertino_popup_props.dart';
import 'package:dropdown_search/src/properties/dropdown_props.dart';
import 'package:dropdown_search/src/properties/infinite_scroll_props.dart';
import 'package:dropdown_search/src/properties/material_popup_props.dart';
import 'package:dropdown_search/src/properties/scroll_props.dart';
import 'package:dropdown_search/src/properties/wrap_props.dart';
import 'package:dropdown_search/src/widgets/custom_chip.dart';
import 'package:dropdown_search/src/widgets/custom_icon_button.dart';
import 'package:dropdown_search/src/widgets/custom_inkwell.dart';
import 'package:dropdown_search/src/widgets/custom_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'adaptive/dialogs.dart';
import 'properties/dropdown_suffix_props.dart';
import 'properties/base_popup_props.dart';
import 'widgets/custom_scroll_view.dart';
import 'widgets/dropdown_search_popup.dart';
import 'adaptive/menu.dart';

typedef DropdownSearchOnFind<T> = FutureOr<List<T>> Function(String filter, LoadProps? loadProps);
typedef DropdownSearchItemAsString<T> = String Function(T item);
typedef DropdownSearchFilterFn<T> = bool Function(T item, String filter);
typedef DropdownSearchCompareFn<T> = bool Function(T item1, T item2);
typedef DropdownSearchBuilder<T> = Widget Function(BuildContext context, T? selectedItem);
typedef DropdownSearchBuilderMultiSelection<T> = Widget Function(BuildContext context, List<T> selectedItems);
typedef DropdownSearchPopupItemBuilder<T> = Widget Function(BuildContext context, T item, bool isDisabled, bool isSelected);
typedef DropdownSearchPopupItemEnabled<T> = bool Function(T item);
typedef ErrorBuilder<T> = Widget Function(BuildContext context, String searchEntry, dynamic exception);
typedef EmptyBuilder<T> = Widget Function(BuildContext context, String searchEntry);
typedef LoadingBuilder<T> = Widget Function(BuildContext context, String searchEntry);
typedef BeforeChange<T> = Future<bool?> Function(T? prevItem, T? nextItem);
typedef BeforePopupOpening<T> = Future<bool?> Function(T? selectedItem);
typedef BeforePopupOpeningMultiSelection<T> = Future<bool?> Function(List<T> selectedItem);
typedef BeforeChangeMultiSelection<T> = Future<bool?> Function(List<T> prevItems, List<T> nextItems);

typedef ValidationMultiSelectionBuilder<T> = Widget Function(BuildContext context, List<T> items);
typedef PositionCallback = RelativeRect Function(RenderBox dropdownBox, RenderBox overlay);
typedef OnItemAdded<T> = void Function(List<T> selectedItems, T addedItem);
typedef OnItemRemoved<T> = void Function(List<T> selectedItems, T removedItem);
typedef ContainerBuilder<T> = Widget Function(BuildContext context, Widget child);

enum PopupMode { dialog, modalBottomSheet, menu, bottomSheet }

enum Mode { form, /*autoComplete,*/ custom }

enum UiMode { adaptive, material, cupertino }

abstract class BaseDropdownSearch<T> extends StatefulWidget {
  ///selected items
  final List<T> selectedItems;

  ///items/data
  final DropdownSearchOnFind<T>? items;

  ///called when a new item is selected
  final ValueChanged<T?>? onChanged;

  ///called when a new items are selected
  final ValueChanged<List<T>>? onChangedMultiSelection;

  ///to customize list of items UI
  final DropdownSearchBuilder<T>? dropdownBuilder;

  ///to customize list of items UI in MultiSelection mode
  final DropdownSearchBuilderMultiSelection<T>? dropdownBuilderMultiSelection;

  /// scroll props for selected item on the dropdown.
  /// example :
  /// ```dart
  ///   SizedBox(
  ///        height: 50,
  ///       child: DropdownSearch<int>.multiSelection(
  ///               items: (f, cs) => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
  ///               selectedItemsScrollProps: ScrollProps(),
  ///         ),
  ///    ),
  ///```
  final ScrollProps? selectedItemsScrollProps;

  final WrapProps? selectedItemsWrapProps;

  final ChipProps? chipProps;

  ///customize the fields the be shown
  final DropdownSearchItemAsString<T>? itemAsString;

  ///	custom filter function
  final DropdownSearchFilterFn<T>? filterFn;

  ///enable/disable dropdownSearch
  final bool enabled;

  ///function that compares two object with the same type to detected if it's the selected item or not
  final DropdownSearchCompareFn<T>? compareFn;

  /// Used to configure the auto validation of [FormField] and [Form] widgets.
  final AutovalidateMode? autoValidateMode;

  /// An optional method to call with the final value when the form is saved via
  final FormFieldSetter<T>? onSaved;

  /// An optional method to call with the final value when the form is saved via
  final FormFieldSetter<List<T>>? onSavedMultiSelection;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  final FormFieldValidator<T>? validator;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  final FormFieldValidator<List<T>>? validatorMultiSelection;

  /// callback executed before applying value change
  final BeforeChange<T>? onBeforeChange;

  /// callback executed before applying values changes
  final BeforeChangeMultiSelection<T>? onBeforeChangeMultiSelection;

  ///define whatever we are in multi selection mode or single selection mode
  final bool isMultiSelectionMode;

  ///custom suffix widget props
  final DropdownSuffixProps suffixProps;

  ///dropdown click properties
  final ClickProps clickProps;

  ///custom popup properties
  final BasePopupProps<T> popupProps;

  ///dropdown decoration props
  final DropDownDecoratorProps decoratorProps;

  ///a callBack will be called before opening le popup
  ///if the callBack return FALSE, the opening of the popup will be cancelled
  final BeforePopupOpening<T>? onBeforePopupOpening;

  ///a callBack will be called before opening le popup
  ///if the callBack return FALSE, the opening of the popup will be cancelled
  final BeforePopupOpeningMultiSelection<T>? onBeforePopupOpeningMultiSelection;

  final Mode mode;

  final UiMode uiMode;

  BaseDropdownSearch({
    super.key,
    T? selectedItem,
    this.mode = Mode.form,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.items,
    this.dropdownBuilder,
    this.suffixProps = const DropdownSuffixProps(),
    this.clickProps = const ClickProps(),
    this.enabled = true,
    this.filterFn,
    this.itemAsString,
    this.compareFn,
    this.onBeforeChange,
    this.onBeforePopupOpening,
    required this.uiMode,
    required this.popupProps,
    //form properties
    this.onSaved,
    this.validator,
    this.chipProps,
    DropDownDecoratorProps? decoratorProps,
  })  : assert(
          T == String || T == int || T == double || compareFn != null,
          '`compareFn` is required',
        ),
        assert(
          mode != Mode.custom || dropdownBuilder != null,
          'Please implement your `dropdownBuilder`',
        ),
        assert(
          mode != Mode.custom || (decoratorProps == null && onSaved == null && validator == null),
          'Custom mode has no form properties',
        ),
        decoratorProps = decoratorProps ?? const DropDownDecoratorProps(),
        selectedItems = _itemToList(selectedItem),
        //to correct
        isMultiSelectionMode = false,
        dropdownBuilderMultiSelection = null,
        validatorMultiSelection = null,
        onBeforeChangeMultiSelection = null,
        onSavedMultiSelection = null,
        onChangedMultiSelection = null,
        onBeforePopupOpeningMultiSelection = null,
        selectedItemsScrollProps = null,
        selectedItemsWrapProps = null;

  const BaseDropdownSearch.multiSelection({
    super.key,
    this.mode = Mode.form,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.items,
    this.suffixProps = const DropdownSuffixProps(),
    this.clickProps = const ClickProps(),
    this.enabled = true,
    this.filterFn,
    this.itemAsString,
    this.compareFn,
    this.selectedItems = const [],
    this.selectedItemsScrollProps,
    required this.popupProps,
    required this.uiMode,
    this.selectedItemsWrapProps,
    ValueChanged<List<T>>? onChanged,
    BeforeChangeMultiSelection<T>? onBeforeChange,
    BeforePopupOpeningMultiSelection<T>? onBeforePopupOpening,
    DropdownSearchBuilderMultiSelection<T>? dropdownBuilder,
    //form properties
    FormFieldSetter<List<T>>? onSaved,
    FormFieldValidator<List<T>>? validator,
    DropDownDecoratorProps? decoratorProps,
    this.chipProps,
  })  : assert(
          T == String || T == int || T == double || compareFn != null,
          '`compareFn` is required',
        ),
        assert(
          mode != Mode.custom || dropdownBuilder != null,
          'Please implement your `dropdownBuilder`',
        ),
        assert(
          mode != Mode.custom || (decoratorProps == null && onSaved == null && validator == null),
          "Custom mode has no form properties",
        ),
        decoratorProps = decoratorProps ?? const DropDownDecoratorProps(),
        onChangedMultiSelection = onChanged,
        onBeforePopupOpeningMultiSelection = onBeforePopupOpening,
        onSavedMultiSelection = onSaved,
        onBeforeChangeMultiSelection = onBeforeChange,
        validatorMultiSelection = validator,
        dropdownBuilderMultiSelection = dropdownBuilder,
        isMultiSelectionMode = true,
        dropdownBuilder = null,
        validator = null,
        onBeforeChange = null,
        onSaved = null,
        onChanged = null,
        onBeforePopupOpening = null;

  static List<T> _itemToList<T>(T? item) {
    List<T?> nullableList = List.filled(1, item);
    return nullableList.whereType<T>().toList();
  }

  @override
  DropdownSearchState<T> createState() => DropdownSearchState<T>();
}

class DropdownSearchState<T> extends State<BaseDropdownSearch<T>> {
  final ValueNotifier<List<T>> _selectedItemsNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _isFocused = ValueNotifier(false);
  final _popupStateKey = GlobalKey<DropdownSearchPopupState<T>>();

  @override
  void initState() {
    super.initState();
    _selectedItemsNotifier.value = List.from(widget.selectedItems);
  }

  @override
  void didUpdateWidget(BaseDropdownSearch<T> oldWidget) {
    if (!listEquals(oldWidget.selectedItems, widget.selectedItems)) {
      _selectedItemsNotifier.value = List.from(widget.selectedItems);
    }

    ///this code check if we need to refresh the popup widget to update
    ///containerBuilder widget
    if (widget.popupProps.containerBuilder != oldWidget.popupProps.containerBuilder) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _popupStateKey.currentState?.setState(() {});
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: _selectedItemsNotifier,
      builder: (context, data, wt) {
        return IgnorePointer(
          ignoring: !widget.enabled,
          child: CustomInkWell(
            clickProps: widget.clickProps,
            onTap: () => _selectSearchMode(),
            child: _dropDown(),
          ),
        );
      },
    );
  }

  Widget _dropDown() {
    if (widget.mode == Mode.custom) {
      return _customField();
    } else {
      return _formField();
    }
  }

  Widget _defaultSelectedItemWidget() {
    Widget defaultItemMultiSelectionMode(T item) {
      return CustomChip(
        label: Text(_itemAsString(item)),
        props: widget.chipProps ?? ChipProps(onDeleted: () => removeItem(item)),
      );
    }

    Widget selectedItemWidget() {
      if (widget.dropdownBuilder != null) {
        return widget.dropdownBuilder!(context, getSelectedItem);
      } else if (widget.dropdownBuilderMultiSelection != null) {
        return widget.dropdownBuilderMultiSelection!(context, getSelectedItems);
      } else if (isMultiSelectionMode) {
        return CustomSingleScrollView(
          scrollProps: widget.selectedItemsScrollProps ?? ScrollProps(),
          child: CustomWrap(
            props: widget.selectedItemsWrapProps ??
                WrapProps(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                ),
            children: getSelectedItems.map((e) => defaultItemMultiSelectionMode(e)).toList(),
          ),
        );
      }
      return Text(
        _itemAsString(getSelectedItem),
        style: _getBaseTextStyle(),
        textAlign: widget.decoratorProps.textAlign,
      );
    }

    return selectedItemWidget();
  }

  TextStyle? _getBaseTextStyle() {
    return widget.enabled
        ? widget.decoratorProps.baseStyle
        : TextStyle(color: Theme.of(context).disabledColor).merge(widget.decoratorProps.baseStyle);
  }

  Widget _formField() {
    return isMultiSelectionMode ? _formFieldMultiSelection() : _formFieldSingleSelection();
  }

  Widget _customField() => _defaultSelectedItemWidget();

  Widget _formFieldSingleSelection() {
    return FormField<T>(
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode,
      initialValue: getSelectedItem,
      builder: (FormFieldState<T> state) {
        if (state.value != getSelectedItem) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              state.didChange(getSelectedItem);
            }
          });
        }
        return ValueListenableBuilder<bool>(
            valueListenable: _isFocused,
            builder: (context, isFocused, w) {
              return InputDecorator(
                baseStyle: _getBaseTextStyle(),
                textAlign: widget.decoratorProps.textAlign,
                textAlignVertical: widget.decoratorProps.textAlignVertical,
                isEmpty: getSelectedItem == null,
                isFocused: isFocused,
                expands: widget.decoratorProps.expands,
                isHovering: widget.decoratorProps.isHovering,
                decoration: _manageDropdownDecoration(state),
                child: _defaultSelectedItemWidget(),
              );
            });
      },
    );
  }

  Widget _formFieldMultiSelection() {
    return FormField<List<T>>(
      enabled: widget.enabled,
      onSaved: widget.onSavedMultiSelection,
      validator: widget.validatorMultiSelection,
      autovalidateMode: widget.autoValidateMode,
      initialValue: widget.selectedItems,
      builder: (FormFieldState<List<T>> state) {
        if (!listEquals(state.value, getSelectedItems)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              state.didChange(getSelectedItems);
            }
          });
        }
        return ValueListenableBuilder<bool>(
            valueListenable: _isFocused,
            builder: (context, isFocused, w) {
              return InputDecorator(
                baseStyle: _getBaseTextStyle(),
                textAlign: widget.decoratorProps.textAlign,
                textAlignVertical: widget.decoratorProps.textAlignVertical,
                isEmpty: getSelectedItems.isEmpty,
                expands: widget.decoratorProps.expands,
                isHovering: widget.decoratorProps.isHovering,
                isFocused: isFocused,
                decoration: _manageDropdownDecoration(state),
                child: _defaultSelectedItemWidget(),
              );
            });
      },
    );
  }

  ///manage dropdownSearch field decoration
  InputDecoration _manageDropdownDecoration(FormFieldState state) {
    return widget.decoratorProps.decoration.applyDefaults(Theme.of(state.context).inputDecorationTheme).copyWith(
          enabled: widget.enabled,
          suffixIcon: _manageSuffixIcons(),
          errorText: state.errorText,
        );
  }

  ///function that return the String value of an object
  String _itemAsString(T? data) {
    if (data == null) {
      return "";
    } else if (widget.itemAsString != null) {
      return widget.itemAsString!(data);
    }

    return data.toString();
  }

  ///function that manage Trailing icons(close, dropDown)
  Widget? _manageSuffixIcons() {
    clearButtonPressed() => clear();
    dropdownButtonPressed() => _selectSearchMode();

    if (!widget.suffixProps.dropdownButtonProps.isVisible && !widget.suffixProps.clearButtonProps.isVisible) return null;

    return Row(
      textDirection: widget.suffixProps.direction,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if (widget.suffixProps.clearButtonProps.isVisible && getSelectedItems.isNotEmpty)
          CustomIconButton(props: widget.suffixProps.clearButtonProps, onPressed: clearButtonPressed),
        if (widget.suffixProps.dropdownButtonProps.isVisible)
          CustomIconButton(
            props: widget.suffixProps.dropdownButtonProps,
            icon:
                isFocused ? widget.suffixProps.dropdownButtonProps.iconOpened : widget.suffixProps.dropdownButtonProps.icon,
            onPressed: dropdownButtonPressed,
          ),
      ],
    );
  }

  Future _openPopup() {
    if (widget.popupProps.mode == PopupMode.dialog) {
      return _openSelectDialog();
    } else if (widget.popupProps.mode == PopupMode.modalBottomSheet) {
      return _openModalBottomSheet();
    } else if (widget.popupProps.mode == PopupMode.bottomSheet) {
      return _openBottomSheet();
    }

    return _openMenu();
  }

  ///open dialog
  Future _openSelectDialog() {
    switch (widget.uiMode) {
      case UiMode.cupertino:
        return openCupertinoDialog(
          context,
          _popupWidgetInstance(),
          isMultiSelectionMode
              ? (widget.popupProps as CupertinoMultiSelectionPopupProps<T>).dialogProps
              : (widget.popupProps as CupertinoPopupProps<T>).dialogProps,
          [
            CupertinoDialogAction(
              child: Text("Cancel"),
              isDestructiveAction: true,
              onPressed: () => _popupStateKey.currentState?.closePopup(),
            ),
            if (isMultiSelectionMode)
              CupertinoDialogAction(
                child: Text("OK"),
                isDefaultAction: true,
                onPressed: () => _popupStateKey.currentState?.onValidate(),
              ),
          ],
        );
      case UiMode.adaptive:
        return openAdaptiveDialog(
          context,
          _popupWidgetInstance(),
          isMultiSelectionMode
              ? (widget.popupProps as AdaptiveMultiSelectionPopupProps<T>).dialogProps
              : (widget.popupProps as AdaptivePopupProps<T>).dialogProps,
          [
            CupertinoDialogAction(
              child: Text("Cancel"),
              isDestructiveAction: true,
              onPressed: () => _popupStateKey.currentState?.closePopup(),
            ),
            if (isMultiSelectionMode)
              CupertinoDialogAction(
                child: Text("OK"),
                isDefaultAction: true,
                onPressed: () => _popupStateKey.currentState?.onValidate(),
              ),
          ],
        );
      case UiMode.material:
      default:
        return openMaterialDialog(
          context,
          _popupWidgetInstance(),
          isMultiSelectionMode
              ? (widget.popupProps as MultiSelectionPopupProps<T>).dialogProps
              : (widget.popupProps as PopupProps<T>).dialogProps,
        );
    }
  }

  Future _openBottomSheet() {
    switch (widget.uiMode) {
      case UiMode.cupertino:
        return openCupertinoBottomSheet(
          context,
          _popupWidgetInstance(),
          isMultiSelectionMode
              ? (widget.popupProps as CupertinoMultiSelectionPopupProps<T>).bottomSheetProps
              : (widget.popupProps as CupertinoPopupProps<T>).bottomSheetProps,
        );
      case UiMode.adaptive:
        return openAdaptiveBottomSheet(
          context,
          _popupWidgetInstance(),
          isMultiSelectionMode
              ? (widget.popupProps as AdaptiveMultiSelectionPopupProps<T>).bottomSheetProps
              : (widget.popupProps as AdaptivePopupProps<T>).bottomSheetProps,
        );
      case UiMode.material:
      default:
        return openMaterialBottomSheet(
          context,
          _popupWidgetInstance(),
          isMultiSelectionMode
              ? (widget.popupProps as MultiSelectionPopupProps<T>).bottomSheetProps
              : (widget.popupProps as PopupProps<T>).bottomSheetProps,
        );
    }
  }

  ///open BottomSheet (Dialog mode)
  Future _openModalBottomSheet() {
    switch (widget.uiMode) {
      case UiMode.cupertino:
        return openCupertinoModalBottomSheet(
          context,
          _popupWidgetInstance(),
          isMultiSelectionMode
              ? (widget.popupProps as CupertinoMultiSelectionPopupProps<T>).modalBottomSheetProps
              : (widget.popupProps as CupertinoPopupProps<T>).modalBottomSheetProps,
          isMultiSelectionMode ? [CupertinoActionSheetAction(onPressed: () {}, child: Text('OK'))] : null,
        );
      case UiMode.adaptive:
        return openAdaptiveModalBottomSheet(
          context,
          _popupWidgetInstance(),
          isMultiSelectionMode
              ? (widget.popupProps as AdaptiveMultiSelectionPopupProps<T>).modalBottomSheetProps
              : (widget.popupProps as AdaptivePopupProps<T>).modalBottomSheetProps,
          isMultiSelectionMode ? [CupertinoActionSheetAction(onPressed: () {}, child: Text('OK'))] : null,
        );
      case UiMode.material:
      default:
        return openMaterialModalBottomSheet(
          context,
          _popupWidgetInstance(),
          isMultiSelectionMode
              ? (widget.popupProps as MultiSelectionPopupProps<T>).modalBottomSheetProps
              : (widget.popupProps as PopupProps<T>).modalBottomSheetProps,
        );
    }
  }

  ///openMenu
  Future _openMenu() {
    dynamic menuProps = widget.popupProps;
    if (widget.uiMode == UiMode.cupertino) {
      menuProps = isMultiSelectionMode
          ? widget.popupProps as CupertinoMultiSelectionPopupProps<T>
          : widget.popupProps as CupertinoPopupProps<T>;
    } else if (widget.uiMode == UiMode.adaptive) {
      menuProps = isMultiSelectionMode
          ? widget.popupProps as AdaptiveMultiSelectionPopupProps<T>
          : widget.popupProps as AdaptivePopupProps<T>;
    } else {
      menuProps =
          isMultiSelectionMode ? widget.popupProps as MultiSelectionPopupProps<T> : widget.popupProps as CupertinoMenuProps<T>;
    }
    return openMenu<T>(
      menuProps: menuProps.menuProps,
      props: widget.popupProps,
      parentContext: context,
      child: _popupWidgetInstance(),
    );
  }

  Widget _popupWidgetInstance() {
    return DropdownSearchPopup<T>(
      key: _popupStateKey,
      uiMode: widget.uiMode,
      props: widget.popupProps,
      itemAsString: widget.itemAsString,
      filterFn: widget.filterFn,
      items: widget.items,
      onChanged: _handleOnChangeSelectedItems,
      compareFn: widget.compareFn,
      isMultiSelectionMode: isMultiSelectionMode,
      defaultSelectedItems: List.from(getSelectedItems),
    );
  }

  ///Function that manage focus listener
  ///set true only if the widget already not focused to prevent unnecessary build
  ///same thing for clear focus,
  void _handleFocus(bool isFocused) {
    if (isFocused && !_isFocused.value) {
      FocusScope.of(context).unfocus();
      _isFocused.value = true;
    } else if (!isFocused && _isFocused.value) {
      _isFocused.value = false;
    }
  }

  ///handle on change value , if the validation is active , we validate the new selected item
  void _handleOnChangeSelectedItems(List<T> selectedItems) {
    changeItem() {
      _selectedItemsNotifier.value = List.from(selectedItems);
      if (widget.onChanged != null) {
        widget.onChanged!(getSelectedItem);
      } else if (widget.onChangedMultiSelection != null) {
        widget.onChangedMultiSelection!(selectedItems);
      }
    }

    if (widget.onBeforeChange != null) {
      widget.onBeforeChange!(getSelectedItem, selectedItems.isEmpty ? null : selectedItems.first).then((value) {
        if (value == true) {
          changeItem();
        }
      });
    } else if (widget.onBeforeChangeMultiSelection != null) {
      widget.onBeforeChangeMultiSelection!(getSelectedItems, selectedItems).then((value) {
        if (value == true) {
          changeItem();
        }
      });
    } else {
      changeItem();
    }

    _handleFocus(false);
  }

  ///compared two items base on user params
  bool _isEqual(T i1, T i2) {
    if (widget.compareFn != null) {
      return widget.compareFn!(i1, i2);
    } else {
      return i1 == i2;
    }
  }

  ///Function that return then UI based on searchMode
  ///[data] selected item to be passed to the UI
  ///If we close the popup , or maybe we just selected
  ///another widget we should clear the focus
  Future<void> _selectSearchMode() async {
    //fix Duplicate GlobalKey detected in widget tree.
    //if the popup not yet disposed do nothing => solve issue fast click
    if (_popupStateKey.currentState != null) return;

    //handle onBefore popupOpening
    if (widget.onBeforePopupOpening != null) {
      if (await widget.onBeforePopupOpening!(getSelectedItem) == false) return;
    } else if (widget.onBeforePopupOpeningMultiSelection != null) {
      if (await widget.onBeforePopupOpeningMultiSelection!(getSelectedItems) == false) return;
    }

    _handleFocus(true);
    await _openPopup();
    _handleFocus(false);
  }

  @override
  void dispose() {
    _popupStateKey.currentState?.closePopup();
    super.dispose();
  }

  ///Change selected Value; this function is public USED to change the selected
  ///value PROGRAMMATICALLY, Otherwise you can use [_handleOnChangeSelectedItems]
  ///for multiSelection mode you can use [changeSelectedItems]
  void changeSelectedItem(T? selectedItem) => _handleOnChangeSelectedItems(BaseDropdownSearch._itemToList(selectedItem));

  ///Change selected Value; this function is public USED to change the selected
  ///value PROGRAMMATICALLY, Otherwise you can use [_handleOnChangeSelectedItems]
  ///for SingleSelection mode you can use [changeSelectedItem]
  void changeSelectedItems(List<T> selectedItems) => _handleOnChangeSelectedItems(selectedItems);

  ///function to remove an item from the list
  ///Useful in multiSelection mode to delete an item
  void removeItem(T itemToRemove) =>
      _handleOnChangeSelectedItems(getSelectedItems..removeWhere((i) => _isEqual(itemToRemove, i)));

  ///Change selected Value; this function is public USED to clear selected
  ///value PROGRAMMATICALLY, Otherwise you can use [_handleOnChangeSelectedItems]
  void clear() => _handleOnChangeSelectedItems([]);

  ///get selected value programmatically USED for SINGLE_SELECTION mode
  T? get getSelectedItem => getSelectedItems.isEmpty ? null : getSelectedItems.first;

  ///get selected values programmatically
  List<T> get getSelectedItems => _selectedItemsNotifier.value;

  ///check if the dropdownSearch is focused
  bool get isFocused => _isFocused.value;

  ///return true if we are in multiSelection mode , false otherwise
  bool get isMultiSelectionMode => widget.isMultiSelectionMode;

  ///Deselect items programmatically on the popup of selection
  void popupDeselectItems(List<T> itemsToDeselect) {
    _popupStateKey.currentState?.deselectItems(itemsToDeselect);
  }

  ///Deselect ALL items programmatically on the popup of selection
  void popupDeselectAllItems() {
    _popupStateKey.currentState?.deselectAllItems();
  }

  ///select ALL items programmatically on the popup of selection
  void popupSelectAllItems() {
    _popupStateKey.currentState?.selectAllItems();
  }

  ///select items programmatically on the popup of selection
  void popupSelectItems(List<T> itemsToSelect) {
    _popupStateKey.currentState?.selectItems(itemsToSelect);
  }

  ///validate selected items programmatically on the popup of selection
  void popupOnValidate() {
    _popupStateKey.currentState?.onValidate();
  }

  ///validate selected items programmatically passed in param [itemsToValidate]
  void popupValidate(List<T> itemsToValidate) {
    closeDropDownSearch();
    changeSelectedItems(itemsToValidate);
  }

  ///Public Function that return then UI based on searchMode
  ///[data] selected item to be passed to the UI
  ///If we close the popup , or maybe we just selected
  ///another widget we should clear the focus
  ///THIS USED FOR OPEN DROPDOWN_SEARCH PROGRAMMATICALLY,
  ///otherwise you can you [_selectSearchMode]
  void openDropDownSearch() => _selectSearchMode();

  ///return the state of the popup
  DropdownSearchPopupState<T>? get getPopupState => _popupStateKey.currentState;

  ///close dropdownSearch popup if it's open
  void closeDropDownSearch() => _popupStateKey.currentState?.closePopup();

  ///returns true if all popup's items are selected; other wise False
  bool get popupIsAllItemSelected => _popupStateKey.currentState?.isAllItemSelected ?? false;

  ///returns popup selected items
  List<T> get popupGetSelectedItems => _popupStateKey.currentState?.getSelectedItem ?? [];

  ///returns popup showed/loaded items
  List<T> get popupGetItems => _popupStateKey.currentState?.getLoadedItems ?? [];

  void updatePopupState() => _popupStateKey.currentState?.setState(() {});
}
