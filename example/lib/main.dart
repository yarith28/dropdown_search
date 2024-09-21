import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          Expanded(
            child: DropdownSearch(
              items: (filter, loadProps) => ["133", "2", "3", "4", "5"],
              uiMode: UiMode.material,
              popupProps: PopupProps<String>.dialog(
                showSearchBox: true,
              ),
            ),
          ),
          Expanded(
            child: DropdownSearch(
              items: (filter, loadProps) => ["1\n30\n33", "2", "3", "4", "5"],
            ),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: DropdownSearch.multiSelection(
              items: (filter, loadProps) => ["1\n30\n33", "2", "3", "4", "5"],
            ),
          )
        ],
      ),
    );
  }
}
