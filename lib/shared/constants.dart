import "package:flutter/material.dart";

const textInputDecoration = InputDecoration(
  fillColor: kSecondaryColor,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white24, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      borderSide: BorderSide(color: Colors.redAccent, width: 2.0)
  ),
);

const kPrimaryColor =Color(0xFFe53935);
const kSecondaryColor =Color(0xFFff867c);

const kThirdColor =Color(0xFFff5f4e);
