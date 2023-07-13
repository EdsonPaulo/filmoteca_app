import 'package:flutter/material.dart';

class SuggestionsTab extends StatefulWidget {
  final int movieId;

  const SuggestionsTab({super.key, required this.movieId});

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
