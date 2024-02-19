import 'package:flutter/material.dart';

InkWell lstile({
  void Function()? onTap,
  Widget? leading,
  Color? splashColor,
  Color? tileColor,
  Widget? title,
}) {
  return InkWell(
    onTap: onTap,
    splashColor: splashColor ?? Colors.amber,
    child: ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // splashColor: splashColor ?? Colors.amber,
      tileColor: tileColor,
      title: title,
      // onTap: onTap,
      leading: leading,
    ),
  );
}
