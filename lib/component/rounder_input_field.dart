import 'package:beaconapplication/component/text_field_container.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';

class RoundedInputField extends StatelessWidget {

  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> validator;
  final InputDecoration deco;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon ,
    this.onChanged,
    this.validator,
    this.deco,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        cursorColor: kSecondaryColor,
        decoration: deco,
      ),
    );
  }
}