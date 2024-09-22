import 'package:dropdown_search/src/properties/suggestions_props.dart';
import 'package:flutter/material.dart';

import 'custom_inkwell.dart';
import 'custom_scroll_view.dart';

class SuggestionsWidget<T> extends StatelessWidget {
  final SuggestionsProps<T> props;
  final List<T> dropdownItems;
  final bool Function(T item) isSelectedItemFn;
  final bool Function(T item) isDisabledItemFn;
  final String Function(T item) itemAsString;
  final ValueChanged<T>? onClick;

  const SuggestionsWidget({
    super.key,
    this.onClick,
    required this.dropdownItems,
    required this.props,
    required this.isSelectedItemFn,
    required this.isDisabledItemFn,
    required this.itemAsString,
  });

  @override
  Widget build(BuildContext context) {
    if (!props.showSuggestions || props.items == null) {
      return const SizedBox.shrink();
    }

    final suggestedItems = props.items!(dropdownItems);
    //pass items to builder even if it's empty, letting user decide what to do in that case
    if (props.builder != null) {
      return props.builder!(suggestedItems);
    }

    if (dropdownItems.isEmpty || suggestedItems.isEmpty) {
      return const SizedBox.shrink();
    }

    final lItemProps = props.itemProps ?? SuggestedItemProps();
    Widget suggestedItemDefaultWidget(T item) {
      final lIsDisabled = isDisabledItemFn(item);
      return Card.filled(
        shape: OutlineInputBorder(borderSide: BorderSide.none),
        color: Theme.of(context).primaryColorLight.withOpacity(lIsDisabled ? 0.3 : 1.0),
        child: CustomInkWell(
          clickProps: lItemProps.itemClickProps,
          onTap: lIsDisabled || onClick == null ? null : () => onClick!(item),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(itemAsString(item), textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall),
                Padding(padding: EdgeInsets.only(left: 8)),
                Visibility(child: Icon(Icons.check_box_outlined), visible: isSelectedItemFn(item))
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      constraints: BoxConstraints(maxHeight: 100),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: CustomSingleScrollView(
        scrollProps: lItemProps.scrollProps,
        child: Wrap(
          runSpacing: 4,
          spacing: 4,
          direction: lItemProps.scrollProps.scrollDirection,
          runAlignment: lItemProps.suggestedItemsAlignment,
          children: suggestedItems
              .map(
                (s) => lItemProps.itemBuilder != null
                    ? CustomInkWell(
                        onTap: isDisabledItemFn(s) || onClick == null ? null : () => onClick!(s),
                        clickProps: lItemProps.itemClickProps,
                        child: IgnorePointer(
                          child: lItemProps.itemBuilder!(context, s, isSelectedItemFn(s), isDisabledItemFn(s)),
                        ),
                      )
                    : suggestedItemDefaultWidget(s),
              )
              .toList(),
        ),
      ),
    );
  }
}
