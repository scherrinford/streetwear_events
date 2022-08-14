import 'package:flutter/material.dart';
import 'package:streetwear_events/models/user_data.dart';
import 'package:streetwear_events/utilities/constants.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {

  final Color backgroundColor = Colors.red;
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  const BaseAppBar({required this.title, required this.appBar, required this.widgets});

  @override
  Widget build(BuildContext context) {

    return AppBar(
        title: title,
        backgroundColor: themeDarkColor,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}