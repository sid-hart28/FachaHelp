import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.grey)),
  hintText: 'Enter a value',
);
