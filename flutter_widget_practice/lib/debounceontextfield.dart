import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/textformfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DebounceOnTextFormField extends StatefulWidget {
  const DebounceOnTextFormField({super.key});

  @override
  State<DebounceOnTextFormField> createState() =>
      _DebounceOnTextFormFieldState();
}

class _DebounceOnTextFormFieldState extends State<DebounceOnTextFormField> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchCtrl = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: textformfield(
            searchCtrl,
            'Enter data',
            'Username',
            RegExp(r'[a-zA-Z1-90]'),
            onchanged: _onSearch,
          ),
        ),
      ),
    );
  }

  _onSearch(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(
      const Duration(seconds: 2),
      () {
        Fluttertoast.showToast(msg: 'Hello These is Debounce...');
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
