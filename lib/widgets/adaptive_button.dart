import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final VoidCallback showDate;
  AdaptiveButton(this.text, this.showDate);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(text,
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: showDate,
          )
        : TextButton(
            onPressed: showDate,
            child: Text(text,
                style: TextStyle(color: Theme.of(context).primaryColor)),
          );
  }
}
