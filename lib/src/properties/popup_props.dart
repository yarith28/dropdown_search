import 'package:flutter/material.dart';

import '../../dropdown_search.dart';

abstract class AbstractPopup<T> {
  final UiMode uiMode;

  /// popup title
  final Widget? title;

  /// the search box will be shown if true, hidden otherwise
  final bool showSearchBox;

  /// custom UI for the item
  final DropdownSearchPopupItemBuilder<T>? itemBuilder;

  /// object that passes all props to search field
  final TextFieldProps searchFieldProps;

  /// props for selection list view
  final ListViewProps listViewProps;

  /// scrollbar properties
  final ScrollbarProps scrollbarProps;

  /// callback executed before applying value change
  /// delay before searching, change it to Duration(milliseconds: 0)
  /// if you do not use online search
  final Duration searchDelay;

  ///called when popup is dismissed
  final VoidCallback? onDismissed;

  ///custom layout for empty results
  final EmptyBuilder? emptyBuilder;

  ///custom layout for loading items
  final LoadingBuilder? loadingBuilder;

  ///custom layout for error
  final ErrorBuilder? errorBuilder;

  ///defines if an item of the popup is enabled or not, if the item is disabled,
  ///it cannot be clicked
  final DropdownSearchPopupItemEnabled<T>? disabledItemFn;

  ///popup mode
  final PopupMode mode;

  ///select the selected item in the menu/dialog/bottomSheet of items
  final bool showSelectedItems;

  ///false if the filter on items is applied by the plugin
  ///true if you want to handle by yourself the filtering (data already filtered by DB, API, ....)
  final bool disableFilter;

  ///if true, once all items are loaded, filtering is applied on cached items (no need to re call the API to get items)
  ///[cacheItems] and [disableFilter] could not be both true
  final bool cacheItems;

  ///suggested items props
  final SuggestedItemProps<T> suggestedItemProps;

  ///dialog mode props
  final AbstractDialogProps dialogProps;

  ///BottomSheet mode props
  final AbstractBottomSheetProps bottomSheetProps;

  ///ModalBottomSheet mode props
  final AbstractModalBottomSheetProps modalBottomSheetProps;

  ///Menu mode props
  final AbstractMenuProps menuProps;

  ///fit height depending on nb of result or keep height fix.
  final FlexFit fit;

  ///used as container to the popup widget
  ///this could be very useful if you want to add extra actions/widget to the popup
  ///the popup widget is considered as a child
  final PopupBuilder? containerBuilder;

  ///popup constraints
  final BoxConstraints constraints;

  ///if true , the callbacks (onTap, onLongClick...) will be handled by the user
  final bool interceptCallBacks;

  ///infinite scroll params like skip (offset), take,...
  final InfiniteScrollProps? infiniteScrollProps;

  /// called when loading new items
  final ValueChanged<List<T>>? onItemsLoaded;

  ///called when a new item added on Multi selection mode
  final OnItemAdded<T>? onItemAdded;

  ///called when a new item added on Multi selection mode
  final OnItemRemoved<T>? onItemRemoved;

  ///widget used to show checked items in multiSelection mode
  final DropdownSearchPopupItemBuilder<T>? checkBoxBuilder;

  ///widget used to validate items in multiSelection mode
  final ValidationMultiSelectionBuilder<T>? validationBuilder;

  final TextDirection textDirection;

  ///properties of click
  final ClickProps itemClickProps;

  const AbstractPopup({
    this.onItemAdded,
    this.onItemRemoved,
    this.checkBoxBuilder,
    this.validationBuilder,
    this.textDirection = TextDirection.ltr,
    this.mode = PopupMode.menu,
    this.uiMode = UiMode.material,
    this.fit = FlexFit.tight,
    this.title,
    this.showSearchBox = false,
    this.searchFieldProps = const TextFieldProps(),
    this.scrollbarProps = const ScrollbarProps(),
    this.listViewProps = const ListViewProps(),
    this.suggestedItemProps = const SuggestedItemProps(),
    this.searchDelay = const Duration(seconds: 1),
    this.onDismissed,
    this.emptyBuilder,
    this.itemBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.showSelectedItems = false,
    this.disabledItemFn,
    this.disableFilter = false,
    this.cacheItems = false,
    this.containerBuilder,
    this.constraints = const BoxConstraints(),
    this.interceptCallBacks = false,
    this.infiniteScrollProps,
    this.onItemsLoaded,
    this.itemClickProps = const ClickProps(),

    this.bottomSheetProps = const BottomSheetProps(),
    this.dialogProps = const DialogProps(),
    this.modalBottomSheetProps = const ModalBottomSheetProps(),
    this.menuProps = const MenuProps(),
  });
}

class MenuPopupProps<T> extends AbstractPopup<T> {
  final AbstractMenuProps menuProps;

  const MenuPopupProps({
    this.menuProps = const AbstractMenuProps(),
    super.onItemAdded,
    super.onItemRemoved,
    super.checkBoxBuilder,
    super.validationBuilder,
    super.textDirection = TextDirection.ltr,
    super.mode = PopupMode.menu,
    super.uiMode = true ? UiMode.material: UiMode.adaptive,
    super.fit = FlexFit.tight,
    super.title,
    super.showSearchBox = false,
    super.searchFieldProps,
    super.scrollbarProps,
    super.listViewProps,
    super.suggestedItemProps ,
    super.searchDelay,
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.disabledItemFn,
    super.disableFilter,
    super.cacheItems,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 350),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps,
  });
}

class PopupProps<T> extends AbstractPopup<T> {
  const PopupProps._({
    super.mode = PopupMode.menu,
    super.uiMode = UiMode.material,
    super.fit = FlexFit.tight,
    super.title,
    super.showSearchBox = false,
    super.bottomSheetProps = const BottomSheetProps(),
    super.dialogProps = const DialogProps(),
    super.modalBottomSheetProps = const ModalBottomSheetProps(),
    super.menuProps = const MenuProps(),
    super.searchFieldProps = const TextFieldProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.suggestedItemProps = const SuggestedItemProps(),
    super.searchDelay = const Duration(seconds: 1),
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems = false,
    super.disabledItemFn,
    super.disableFilter = false,
    super.cacheItems = false,
    super.containerBuilder,
    super.constraints = const BoxConstraints(),
    super.interceptCallBacks = false,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps = const ClickProps(),
  }) : assert(infiniteScrollProps == null || disableFilter);

  const PopupProps.menu({
    super.uiMode = UiMode.material,
    super.title,
    super.fit = FlexFit.tight,
    super.showSearchBox = false,
    super.menuProps = const MenuProps(),
    super.searchFieldProps = const TextFieldProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.suggestedItemProps = const SuggestedItemProps(),
    super.searchDelay = const Duration(seconds: 1),
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems = false,
    super.disabledItemFn,
    super.disableFilter = false,
    super.cacheItems = false,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 350),
    super.interceptCallBacks = false,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps = const ClickProps(),
  }) : super(
          mode: PopupMode.menu,
          bottomSheetProps: const BottomSheetProps(),
          dialogProps: const DialogProps(),
          modalBottomSheetProps: const ModalBottomSheetProps(),
        );

  const PopupProps.dialog({
    super.uiMode = UiMode.material,
    super.fit = FlexFit.tight,
    super.title,
    super.showSearchBox = false,
    super.dialogProps = const DialogProps(),
    super.searchFieldProps = const TextFieldProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.suggestedItemProps = const SuggestedItemProps(),
    super.searchDelay = const Duration(seconds: 1),
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems = false,
    super.disabledItemFn,
    super.disableFilter = false,
    super.cacheItems = false,
    super.containerBuilder,
    super.constraints = const BoxConstraints(
      minWidth: 500,
      maxWidth: 500,
      maxHeight: 600,
    ),
    super.interceptCallBacks = false,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps = const ClickProps(),
  }) : super(
          mode: PopupMode.dialog,
          menuProps: const MenuProps(),
          bottomSheetProps: const BottomSheetProps(),
          modalBottomSheetProps: const ModalBottomSheetProps(),
        );

  const PopupProps.bottomSheet({
    super.uiMode = UiMode.material,
    super.fit = FlexFit.tight,
    super.title,
    super.showSearchBox = false,
    super.bottomSheetProps = const BottomSheetProps(),
    super.searchFieldProps = const TextFieldProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.suggestedItemProps = const SuggestedItemProps(),
    super.searchDelay = const Duration(seconds: 1),
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems = false,
    super.disabledItemFn,
    super.disableFilter = false,
    super.cacheItems = false,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 500),
    super.interceptCallBacks = false,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps = const ClickProps(),
  }) : super(
          mode: PopupMode.bottomSheet,
          menuProps: const MenuProps(),
          dialogProps: const DialogProps(),
          modalBottomSheetProps: const ModalBottomSheetProps(),
        );

  const PopupProps.modalBottomSheet({
    super.uiMode = UiMode.material,
    super.title,
    super.fit = FlexFit.tight,
    super.showSearchBox = false,
    super.modalBottomSheetProps = const ModalBottomSheetProps(),
    super.searchFieldProps = const TextFieldProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.suggestedItemProps = const SuggestedItemProps(),
    super.searchDelay = const Duration(seconds: 1),
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems = false,
    super.disabledItemFn,
    super.disableFilter = false,
    super.cacheItems = false,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 500),
    super.interceptCallBacks = false,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps = const ClickProps(),
  }) : super(
          mode: PopupMode.modalBottomSheet,
          menuProps: const MenuProps(),
          dialogProps: const DialogProps(),
          bottomSheetProps: const BottomSheetProps(),
        );
}

class PopupPropsMultiSelection<T> extends PopupProps<T> {
  ///called when a new item added on Multi selection mode
  final OnItemAdded<T>? onItemAdded;

  ///called when a new item added on Multi selection mode
  final OnItemRemoved<T>? onItemRemoved;

  ///widget used to show checked items in multiSelection mode
  final DropdownSearchPopupItemBuilder<T>? checkBoxBuilder;

  ///widget used to validate items in multiSelection mode
  final ValidationMultiSelectionBuilder<T>? validationBuilder;

  final TextDirection textDirection;

  const PopupPropsMultiSelection._({
    super.uiMode,
    super.mode,
    super.fit,
    super.title,
    super.disableFilter,
    super.cacheItems,
    super.itemBuilder,
    super.disabledItemFn,
    super.showSearchBox,
    super.searchFieldProps,
    super.suggestedItemProps,
    super.modalBottomSheetProps,
    super.scrollbarProps,
    super.listViewProps,
    super.searchDelay,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.bottomSheetProps,
    super.dialogProps,
    super.menuProps,
    super.containerBuilder,
    super.constraints,
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps,
    this.onItemAdded,
    this.onItemRemoved,
    this.checkBoxBuilder,
    this.validationBuilder,
    this.textDirection = TextDirection.ltr,
  }) : super._();

  const PopupPropsMultiSelection.menu({
    super.uiMode,
    super.title,
    super.fit,
    super.showSearchBox,
    super.searchFieldProps,
    super.menuProps,
    super.suggestedItemProps,
    super.scrollbarProps,
    super.listViewProps,
    super.searchDelay,
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.disabledItemFn,
    super.disableFilter,
    super.cacheItems,
    super.containerBuilder,
    super.constraints,
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps,
    this.onItemAdded,
    this.onItemRemoved,
    this.checkBoxBuilder,
    this.validationBuilder,
    this.textDirection = TextDirection.ltr,
  }) : super.menu();

  const PopupPropsMultiSelection.dialog({
    super.uiMode,
    super.title,
    super.fit,
    super.showSearchBox,
    super.searchFieldProps,
    super.scrollbarProps,
    super.listViewProps,
    super.suggestedItemProps,
    super.dialogProps,
    super.searchDelay,
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.disabledItemFn,
    super.disableFilter,
    super.cacheItems,
    super.containerBuilder,
    super.constraints,
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps,
    this.onItemAdded,
    this.onItemRemoved,
    this.checkBoxBuilder,
    this.validationBuilder,
    this.textDirection = TextDirection.ltr,
  }) : super.dialog();

  const PopupPropsMultiSelection.bottomSheet({
    super.uiMode,
    super.title,
    super.fit,
    super.showSearchBox,
    super.searchFieldProps,
    super.listViewProps,
    super.suggestedItemProps,
    super.bottomSheetProps,
    super.scrollbarProps,
    super.searchDelay,
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.disabledItemFn,
    super.disableFilter,
    super.cacheItems,
    super.containerBuilder,
    super.constraints,
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps,
    this.onItemAdded,
    this.onItemRemoved,
    this.checkBoxBuilder,
    this.validationBuilder,
    this.textDirection = TextDirection.ltr,
  }) : super.bottomSheet();

  const PopupPropsMultiSelection.modalBottomSheet({
    super.uiMode,
    super.title,
    super.disableFilter,
    super.cacheItems,
    super.fit = FlexFit.tight,
    super.itemBuilder,
    super.disabledItemFn,
    super.showSearchBox,
    super.searchFieldProps,
    super.suggestedItemProps,
    super.modalBottomSheetProps,
    super.scrollbarProps,
    super.listViewProps,
    super.searchDelay,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.containerBuilder,
    super.constraints,
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    super.itemClickProps,
    this.onItemAdded,
    this.onItemRemoved,
    this.checkBoxBuilder,
    this.validationBuilder,
    this.textDirection = TextDirection.ltr,
  }) : super.modalBottomSheet();

  PopupPropsMultiSelection.from(PopupProps<T> popupProps)
      : this._(
          uiMode: popupProps.uiMode,
          title: popupProps.title,
          fit: popupProps.fit,
          suggestedItemProps: popupProps.suggestedItemProps,
          disabledItemFn: popupProps.disabledItemFn,
          emptyBuilder: popupProps.emptyBuilder,
          errorBuilder: popupProps.errorBuilder,
          disableFilter: popupProps.disableFilter,
          cacheItems: popupProps.cacheItems,
          itemBuilder: popupProps.itemBuilder,
          listViewProps: popupProps.listViewProps,
          loadingBuilder: popupProps.loadingBuilder,
          modalBottomSheetProps: popupProps.modalBottomSheetProps,
          onDismissed: popupProps.onDismissed,
          scrollbarProps: popupProps.scrollbarProps,
          searchDelay: popupProps.searchDelay,
          searchFieldProps: popupProps.searchFieldProps,
          showSearchBox: popupProps.showSearchBox,
          showSelectedItems: popupProps.showSelectedItems,
          mode: popupProps.mode,
          bottomSheetProps: popupProps.bottomSheetProps,
          dialogProps: popupProps.dialogProps,
          menuProps: popupProps.menuProps,
          containerBuilder: popupProps.containerBuilder,
          constraints: popupProps.constraints,
          interceptCallBacks: popupProps.interceptCallBacks,
          textDirection: TextDirection.ltr,
          infiniteScrollProps: popupProps.infiniteScrollProps,
          onItemsLoaded: popupProps.onItemsLoaded,
          itemClickProps: popupProps.itemClickProps,
          onItemAdded: null,
          onItemRemoved: null,
          checkBoxBuilder: null,
          validationBuilder: null,
        );
}
