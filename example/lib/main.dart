import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user_model.dart';

Future<List<UserModel>> getData(filter) async {
  var response = await Dio().get(
    "https://63c1210999c0a15d28e1ec1d.mockapi.io/users",
    queryParameters: {"filter": filter},
  );

  final data = response.data;
  if (data != null) {
    return UserModel.fromJsonList(data);
  }

  return [];
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: Material(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CupertinoDropdownSearch<String>.multiSelection(
                  items: (filter, loadProps) => ["1", "2", "3"],
                  selectedItems: ["2", '3'],
                  suffixProps: DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
                  popupProps: CupertinoMultiSelectionPopupProps.modalBottomSheet(
                    //fit: FlexFit.loose,
                    //constraints: BoxConstraints.loose(height: 400, width: 300),
                    suggestionsProps: SuggestionsProps(showSuggestions: true, items: (items) => ["1", "2", "3", "4"]),
                    showSearchBox: true,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Row(
                  children: [
                    Expanded(child: TextField(decoration: InputDecoration(border: OutlineInputBorder()),)),
                    Padding(padding: EdgeInsets.only(right: 8)),
                    Expanded(
                      child: DropdownSearch<String>.multiSelection(
                        items: (filter, loadProps) => ["1", "2", "3"],
                        selectedItems: ["2", '3'],
                        suffixProps: DropdownSuffixProps(clearButtonProps: ClearButtonProps(isVisible: true)),
                        popupProps: MultiSelectionPopupProps.modalBottomSheet(
                          //fit: FlexFit.loose,
                          //constraints: BoxConstraints.loose(height: 400, width: 300),
                          suggestionsProps: SuggestionsProps(
                            showSuggestions: true,
                            items: (items) => ["1", "2", "3", "4"],
                            itemProps: SuggestedItemProps(chipProps: ChipProps())
                          ),
                          showSearchBox: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
