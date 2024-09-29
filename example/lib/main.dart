import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoActionSheetExample(),
    );
  }
}

class CupertinoActionSheetExample extends StatelessWidget {
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext cnt) {
        var remember = true;

        return Material(
          color: Colors.transparent,
          child: CupertinoActionSheet(
            message: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return Wrap(
                  children: <Widget>[
                    Text('Do you want to count \'Completed\' events as part of Return Visits?'),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Remember this selection'),
                          Switch(
                            value: remember,
                            onChanged: (value) {
                              setState(() {
                                remember = value;
                              });
                            },
                            activeTrackColor: Colors.lightBlue[200],
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context, 0);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              child: Text('Yes'),
              onPressed: () {
                Navigator.pop(context, 1);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('CupertinoActionSheet Example'),
      ),
      child: Center(
        child: CupertinoButton(
          child: Text('Show Action Sheet'),
          onPressed: () => _showActionSheet(context),
        ),
      ),
    );
  }
}
