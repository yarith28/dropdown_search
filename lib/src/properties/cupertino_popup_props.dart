import 'package:dropdown_search/src/base_dropdown_search.dart';
import 'package:dropdown_search/src/properties/base_popup_props.dart';
import 'package:dropdown_search/src/properties/bottom_sheet_props.dart';
import 'package:dropdown_search/src/properties/dialog_props.dart';
import 'package:dropdown_search/src/properties/dropdown_props.dart';
import 'package:dropdown_search/src/properties/list_view_props.dart';
import 'package:dropdown_search/src/properties/menu_props.dart';
import 'package:dropdown_search/src/properties/modal_bottom_sheet_props.dart';
import 'package:dropdown_search/src/properties/scrollbar_props.dart';
import 'package:dropdown_search/src/properties/suggestions_props.dart';
import 'package:dropdown_search/src/properties/text_field_props.dart';
import 'package:flutter/material.dart';

class CupertinoMultiSelectionPopupProps<T> extends BasePopupProps<T> {
  ///dialog mode props
  final CupertinoDialogProps dialogProps;

  ///BottomSheet mode props
  final CupertinoBottomSheetProps bottomSheetProps;

  ///ModalBottomSheet mode props
  final CupertinoModalBottomSheetProps modalBottomSheetProps;

  ///Menu mode props
  final CupertinoMenuProps menuProps;

  const CupertinoMultiSelectionPopupProps.menu({
    this.menuProps = const CupertinoMenuProps(),
    super.fit = FlexFit.tight,
    super.searchFieldProps = const TextFieldProps(),
    super.suggestionsProps = const SuggestionsProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.searchDelay = const Duration(seconds: 1),
    super.itemClickProps = const ClickProps(),
    super.showSearchBox = false,
    super.title,
    super.disableFilter,
    super.cacheItems,
    super.itemBuilder,
    super.disabledItemFn,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 350),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    //multi selection props
    super.onItemAdded,
    super.onItemRemoved,
    super.checkBoxBuilder,
    super.validationBuilder,
    super.textDirection = TextDirection.ltr,
  })  : bottomSheetProps = const CupertinoBottomSheetProps(),
        dialogProps = const CupertinoDialogProps(),
        modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
        super(mode: PopupMode.menu);

  const CupertinoMultiSelectionPopupProps.dialog({
    this.dialogProps = const CupertinoDialogProps(),
    super.fit = FlexFit.tight,
    super.searchFieldProps = const TextFieldProps(),
    super.suggestionsProps = const SuggestionsProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.searchDelay = const Duration(seconds: 1),
    super.itemClickProps = const ClickProps(),
    super.showSearchBox = false,
    super.title,
    super.disableFilter,
    super.cacheItems,
    super.itemBuilder,
    super.disabledItemFn,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.containerBuilder,
    super.constraints = const BoxConstraints(
      minWidth: 500,
      maxWidth: 500,
      maxHeight: 600,
    ),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    //multi selection props
    super.onItemAdded,
    super.onItemRemoved,
    super.checkBoxBuilder,
    super.validationBuilder,
    super.textDirection = TextDirection.ltr,
  })  : bottomSheetProps = const CupertinoBottomSheetProps(),
        menuProps = const CupertinoMenuProps(),
        modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
        super(mode: PopupMode.dialog);

  const CupertinoMultiSelectionPopupProps.bottomSheet({
    this.bottomSheetProps = const CupertinoBottomSheetProps(),
    super.fit = FlexFit.tight,
    super.searchFieldProps = const TextFieldProps(),
    super.suggestionsProps = const SuggestionsProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.searchDelay = const Duration(seconds: 1),
    super.itemClickProps = const ClickProps(),
    super.showSearchBox = false,
    super.title,
    super.disableFilter,
    super.cacheItems,
    super.itemBuilder,
    super.disabledItemFn,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 500),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    //multi selection props
    super.onItemAdded,
    super.onItemRemoved,
    super.checkBoxBuilder,
    super.validationBuilder,
    super.textDirection = TextDirection.ltr,
  })  : menuProps = const CupertinoMenuProps(),
        dialogProps = const CupertinoDialogProps(),
        modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
        super(mode: PopupMode.bottomSheet);

  const CupertinoMultiSelectionPopupProps.modalBottomSheet({
    this.modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
    super.fit = FlexFit.tight,
    super.searchFieldProps = const TextFieldProps(),
    super.suggestionsProps = const SuggestionsProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.searchDelay = const Duration(seconds: 1),
    super.itemClickProps = const ClickProps(),
    super.showSearchBox = false,
    super.title,
    super.disableFilter,
    super.cacheItems,
    super.itemBuilder,
    super.disabledItemFn,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 500),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
    //multi selection props
    super.onItemAdded,
    super.onItemRemoved,
    super.checkBoxBuilder,
    super.validationBuilder,
    super.textDirection = TextDirection.ltr,
  })  : menuProps = const CupertinoMenuProps(),
        bottomSheetProps = const CupertinoBottomSheetProps(),
        dialogProps = const CupertinoDialogProps(),
        super(mode: PopupMode.modalBottomSheet);
}

class CupertinoPopupProps<T> extends BasePopupProps<T> {
  ///dialog mode props
  final CupertinoDialogProps dialogProps;

  ///BottomSheet mode props
  final CupertinoBottomSheetProps bottomSheetProps;

  ///ModalBottomSheet mode props
  final CupertinoModalBottomSheetProps modalBottomSheetProps;

  ///Menu mode props
  final CupertinoMenuProps menuProps;

  const CupertinoPopupProps.menu({
    this.menuProps = const CupertinoMenuProps(),
    super.fit,
    super.searchFieldProps,
    super.suggestionsProps,
    super.scrollbarProps,
    super.listViewProps,
    super.searchDelay,
    super.itemClickProps,
    super.showSearchBox,
    super.title,
    super.disableFilter,
    super.cacheItems,
    super.itemBuilder,
    super.disabledItemFn,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 350),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
  })  : bottomSheetProps = const CupertinoBottomSheetProps(),
        dialogProps = const CupertinoDialogProps(),
        modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
        super(mode: PopupMode.menu);

  const CupertinoPopupProps.dialog({
    this.dialogProps = const CupertinoDialogProps(),
    super.fit = FlexFit.tight,
    super.searchFieldProps,
    super.suggestionsProps,
    super.scrollbarProps,
    super.listViewProps,
    super.searchDelay,
    super.itemClickProps,
    super.showSearchBox,
    super.title,
    super.disableFilter,
    super.cacheItems,
    super.itemBuilder,
    super.disabledItemFn,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.containerBuilder,
    super.constraints = const BoxConstraints(
      minWidth: 500,
      maxWidth: 500,
      maxHeight: 600,
    ),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
  })  : bottomSheetProps = const CupertinoBottomSheetProps(),
        menuProps = const CupertinoMenuProps(),
        modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
        super(mode: PopupMode.dialog);

  const CupertinoPopupProps.modalBottomSheet({
    this.bottomSheetProps = const CupertinoBottomSheetProps(),
    super.fit = FlexFit.tight,
    super.searchFieldProps,
    super.suggestionsProps,
    super.scrollbarProps,
    super.listViewProps,
    super.searchDelay,
    super.itemClickProps,
    super.showSearchBox,
    super.title,
    super.disableFilter,
    super.cacheItems,
    super.itemBuilder,
    super.disabledItemFn,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 500),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
  })  : menuProps = const CupertinoMenuProps(),
        dialogProps = const CupertinoDialogProps(),
        modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
        super(mode: PopupMode.bottomSheet);

  const CupertinoPopupProps.bottomSheet({
    this.modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
    super.fit = FlexFit.tight,
    super.searchFieldProps,
    super.suggestionsProps,
    super.scrollbarProps,
    super.listViewProps,
    super.searchDelay,
    super.itemClickProps,
    super.showSearchBox,
    super.title,
    super.disableFilter,
    super.cacheItems,
    super.itemBuilder,
    super.disabledItemFn,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 500),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
  })  : menuProps = const CupertinoMenuProps(),
        bottomSheetProps = const CupertinoBottomSheetProps(),
        dialogProps = const CupertinoDialogProps(),
        super(mode: PopupMode.modalBottomSheet);
}
