import 'package:dropdown_search/src/properties/chip_props.dart';
import 'package:dropdown_search/src/properties/dropdown_props.dart';
import 'package:dropdown_search/src/properties/scroll_props.dart';
import 'package:flutter/material.dart';

typedef SuggestionsBuilder<T> = Widget Function(List<T> suggestedItems);
typedef SuggestItemBuilder<T> = Widget Function(BuildContext context, T item, bool isSelected, bool isDisabled);

///[items] are the original item on which we want extract suggestions
typedef SuggestedItems<T> = List<T> Function(List<T> items);

class SuggestionsProps<T> {
  final SuggestedItemProps<T>? itemProps;
  final SuggestionsBuilder<T>? builder;
  final bool showSuggestions;

  ///suggested items list
  final SuggestedItems<T>? items;

  const SuggestionsProps({
    this.itemProps,
    this.builder,
    this.showSuggestions = false,
    this.items,
  }) : assert(
          builder == null || itemProps == null,
          'Cannot provide both a builder and a itemProps. '
          'builder is overriding the hole suggestion widget',
        );
}

class SuggestedItemProps<T> {
  final SuggestItemBuilder<T>? itemBuilder;

  ///favorite items alignment
  final WrapAlignment suggestedItemsAlignment;

  final ClickProps itemClickProps;

  final ScrollProps scrollProps;

  final ChipProps chipProps;

  const SuggestedItemProps({
    this.itemBuilder,
    this.chipProps = const ChipProps(),
    this.suggestedItemsAlignment = WrapAlignment.start,
    this.itemClickProps = const ClickProps(),
    this.scrollProps = const ScrollProps(scrollDirection: Axis.horizontal),
  });
}
