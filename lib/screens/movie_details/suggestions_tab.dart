import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuggestionsTab extends StatefulWidget {
  const SuggestionsTab({super.key});

  @override
  _SuggestionsTab createState() => _SuggestionsTab();
}

class _SuggestionsTab extends State<SuggestionsTab> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Sugestões',
      style: TextStyle(color: Colors.white),
    );
  }
}
