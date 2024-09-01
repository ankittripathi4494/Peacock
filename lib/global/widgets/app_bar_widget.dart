import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarWidget {
  static PreferredSizeWidget appBarWidgetMethod(BuildContext context,
      {Widget? title, bool? automaticallyImplyLeading, List<Widget>? actions}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: const IconThemeData(color: Colors.white),
      title: title,
      centerTitle: true,
      actionsIconTheme: const IconThemeData(color: Colors.white),
      actions: (actions != null) ? actions : null,
    );
  }
}
