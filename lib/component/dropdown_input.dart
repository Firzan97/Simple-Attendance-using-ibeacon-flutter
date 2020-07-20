import 'package:beaconapplication/component/text_field_container.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';

class DropDownInput extends StatelessWidget {
  final List program;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const DropDownInput({
    Key key,
    this.hintText,
    this.icon = Icons.list,
    this.onChanged,
    this.program
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: DropdownButtonFormField(
        onChanged: onChanged,
        items: program,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}