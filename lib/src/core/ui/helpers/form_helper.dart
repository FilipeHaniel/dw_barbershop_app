import 'package:flutter/material.dart';

void unFocus(BuildContext context) => FocusScope.of(context).unfocus();

extension unFocusExtension on BuildContext {
  void unfocus() => Focus.of(this).unfocus();
}
