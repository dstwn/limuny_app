import 'package:flutter/material.dart';
import 'package:limuny/styles/theme.dart' as Style;

class CustomCheckbox extends StatefulWidget {
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isChecked ? Style.Colors.mainColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          border: isChecked
              ? null
              : Border.all(color: Style.Colors.grey, width: 1.5),
        ),
        width: 20,
        height: 20,
        child: isChecked
            ? Icon(
                Icons.check,
                size: 20,
                color: Colors.white,
              )
            : null,
      ),
    );
    ;
  }
}
