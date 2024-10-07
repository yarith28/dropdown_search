import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/src/properties/cupertino_text_field_props.dart';
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
    CupertinoTextFieldProps searchFieldProps = const CupertinoTextFieldProps(),
    super.fit,
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
    //multi selection props
    super.onItemAdded,
    super.onItemRemoved,
    super.checkBoxBuilder,
    super.validationBuilder,
    super.textDirection = TextDirection.ltr,
  })  : bottomSheetProps = const CupertinoBottomSheetProps(),
        dialogProps = const CupertinoDialogProps(),
        modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
        super(mode: PopupMode.menu, searchFieldProps: searchFieldProps);

  const CupertinoMultiSelectionPopupProps.dialog({
    this.dialogProps = const CupertinoDialogProps(),
    CupertinoTextFieldProps searchFieldProps = const CupertinoTextFieldProps(),
    super.fit,
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
    super.constraints = const BoxConstraints.tightFor(height: 400),
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
        super(mode: PopupMode.dialog, searchFieldProps: searchFieldProps);

  const CupertinoMultiSelectionPopupProps.bottomSheet({
    this.bottomSheetProps = const CupertinoBottomSheetProps(),
    CupertinoTextFieldProps searchFieldProps = const CupertinoTextFieldProps(),
    super.fit,
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
    //multi selection props
    super.onItemAdded,
    super.onItemRemoved,
    super.checkBoxBuilder,
    super.validationBuilder,
    super.textDirection = TextDirection.ltr,
  })  : menuProps = const CupertinoMenuProps(),
        dialogProps = const CupertinoDialogProps(),
        modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
        super(mode: PopupMode.bottomSheet, searchFieldProps: searchFieldProps);

  const CupertinoMultiSelectionPopupProps.modalBottomSheet({
    this.modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
    CupertinoTextFieldProps searchFieldProps = const CupertinoTextFieldProps(),
    super.fit = FlexFit.tight,
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
    super.constraints = const BoxConstraints.tightFor(height: 400),
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
        super(mode: PopupMode.modalBottomSheet, searchFieldProps: searchFieldProps);
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
    CupertinoTextFieldProps searchFieldProps = const CupertinoTextFieldProps(),
    super.fit,
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
        super(mode: PopupMode.menu, searchFieldProps: searchFieldProps);

  const CupertinoPopupProps.dialog({
    this.dialogProps = const CupertinoDialogProps(),
    CupertinoTextFieldProps searchFieldProps = const CupertinoTextFieldProps(),
    super.fit = FlexFit.tight,
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
    super.constraints = const BoxConstraints.tightFor(height: 400),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
  })  : bottomSheetProps = const CupertinoBottomSheetProps(),
        menuProps = const CupertinoMenuProps(),
        modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
        super(mode: PopupMode.dialog, searchFieldProps: searchFieldProps);

  const CupertinoPopupProps.modalBottomSheet({
    this.modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
    CupertinoTextFieldProps searchFieldProps = const CupertinoTextFieldProps(),
    super.fit = FlexFit.tight,
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
    super.constraints = const BoxConstraints.tightFor(height: 400),
    super.interceptCallBacks,
    super.infiniteScrollProps,
    super.onItemsLoaded,
  })  : menuProps = const CupertinoMenuProps(),
        dialogProps = const CupertinoDialogProps(),
        bottomSheetProps = const CupertinoBottomSheetProps(),
        super(mode: PopupMode.modalBottomSheet, searchFieldProps: searchFieldProps);

  const CupertinoPopupProps.bottomSheet({
    this.bottomSheetProps = const CupertinoBottomSheetProps(),
    CupertinoTextFieldProps searchFieldProps = const CupertinoTextFieldProps(),
    super.fit = FlexFit.tight,
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
        modalBottomSheetProps = const CupertinoModalBottomSheetProps(),
        dialogProps = const CupertinoDialogProps(),
        super(mode: PopupMode.bottomSheet, searchFieldProps: searchFieldProps);
}
